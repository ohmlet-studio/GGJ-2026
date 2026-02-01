@tool
extends Control

@onready var label_npc = $label_npc
@onready var label_player = $label_player
@onready var prompts: Array[DialogPrompt]
@onready var levels = $Levels
@onready var minigame: Minigame = %Minigame
@onready var tempo_visualizer = $"../TempoVisualizer"
@onready var in_between_scene = %InBetweenScene

@export_range(0, 10, 1) var current_dialog_index: int

@export var level_number: int = 0

func _ready():
	minigame.input_invalid.connect(_on_input_invalid)
	minigame.input_valid.connect(_on_input_valid)
	minigame.input_missed.connect(_on_input_missed)

	play_level_and_in_between(level_number)

func play_level_and_in_between(level_number: int):
	var level_errors_ms = await play_level(level_number)
	
	var good_thought = levels.get_child(level_number).dialog_succes
	var bad_thought = levels.get_child(level_number).dialog_failure
	in_between_scene.show_in_between_scene(level_errors_ms, good_thought, bad_thought)
	
	in_between_scene.next_level.connect(
		func():
			level_number += 1
			$"../IntroBackground".hide()
			play_level_and_in_between(level_number)
	)
	
	in_between_scene.retry_level.connect(
		func():
			play_level_and_in_between(level_number)
	)

func _on_input_valid(offset_ms):
	tempo_visualizer.show_hit()
	
func _on_input_invalid(offset_ms):
	tempo_visualizer.show_miss()

func _on_input_missed():
	tempo_visualizer.show_miss()

func _convert_sequence(string_sequence: String):
	var string_to_enum := {
		"HAPPY": GlobalEnum.directions.UP,
		"SAD": GlobalEnum.directions.DOWN,
		"ANGER": GlobalEnum.directions.RIGHT,
		"SURPRISE" : GlobalEnum.directions.LEFT,
	}
	
	var single_words = string_sequence.strip_edges().split(" ")
	
	var enum_sequence = []
	for word in single_words:
		enum_sequence.append(string_to_enum[word])
	
	return enum_sequence

func _prepare_prompt(level_number: int, index: int):
	var level_node = levels.get_child(level_number)
	var current_prompt = level_node.get_child(index)
	
	if not current_prompt:
		print("ERROR: prompt_node does not exist")
		return

	if not Engine.is_editor_hint():
		Metronome.set_tempo_bpm(current_prompt.tempo_bpm)
	
	var sequence = _convert_sequence(current_prompt.input_sequence)
	minigame.character = current_prompt.character
	minigame.npc_sequence = sequence
	return current_prompt

func _display_text_player(text: String):
	label_player.text = text

func play_level(level_number: int):
	var level_node = levels.get_child(level_number)
	
	var level_error = []

	for i in range(level_node.get_child_count()):
		var error_ms_level = await play_prompt(level_number, i)
		level_error += error_ms_level
		
		# wait one ticks between prompts
		await Metronome.tick
		
	return level_error

func play_prompt(level_number: int, index: int):
	var current_prompt = _prepare_prompt(level_number, index)
	
	# Play music with correct tempo / param is in bpm
	AudioController.play_music(Metronome.get_tempo_bpm(), AudioController.MUSIC_SCENE.LEVEL)
	
	%TalkHint.visible_hint = current_prompt.character
	await label_npc.char2char(current_prompt.char_dialog, 0.025)
	
	# wait two ticks
	await Metronome.tick
	await Metronome.tick

	# use the NPC to show the masks	
	#await minigame.play_sequence_npc()
	
	var prompt_scores = []
	
	print("Letting the user play the minigame")
	minigame.input_valid.connect(func(value): prompt_scores.append(abs(value)))
	minigame.input_invalid.connect(func(_value): prompt_scores.append(-1))
	minigame.input_missed.connect(func(_value): prompt_scores.append(-1))

	await minigame.start_player_turn()
	
	label_npc.text = ""
	_display_text_player(current_prompt.response)
	
	print("PROMPT SCORES: ", prompt_scores)
	return prompt_scores
