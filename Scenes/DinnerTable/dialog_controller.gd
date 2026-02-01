@tool
extends Control

@onready var label_npc = $label_npc
@onready var label_player = $label_player
@onready var prompts: Array[DialogPrompt]
@onready var levels = $Levels
@onready var minigame: Minigame = %Minigame
@onready var tempo_visualizer = $"../TempoVisualizer"

@export_range(0, 10, 1) var current_dialog_index: int

func _ready():
	minigame.input_invalid.connect(_on_input_invalid)
	minigame.input_valid.connect(_on_input_valid)
	minigame.input_missed.connect(_on_input_missed)

	await play_level("Intro")
	await play_level("Level1")

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

func _prepare_prompt(level_name: String, index: int):
	var level_node = levels.get_node(level_name)
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

func play_level(level_name: String):
	var level_node = levels.get_node(level_name)
	

	for i in range(level_node.get_child_count()):
		await play_prompt(level_name, i)
		
		# wait two ticks between prompts
		await Metronome.tick
		await Metronome.tick

func play_prompt(level_name: String, index: int):
	var current_prompt = _prepare_prompt(level_name, index)
	
	# Play music with correct tempo / param is in bpm
	AudioController.play_music(Metronome.get_tempo_bpm(), AudioController.MUSIC_SCENE.LEVEL)
	
	%TalkHint.visible_hint = current_prompt.character
	await label_npc.char2char(current_prompt.char_dialog, 0.025)
	
	# wait two ticks
	await Metronome.tick
	await Metronome.tick

	# use the NPC to show the masks	
	#await minigame.play_sequence_npc()
	
	print("Letting the user play the minigame")
	await minigame.start_player_turn()
	
	label_npc.text = ""
	_display_text_player(current_prompt.response)
	
