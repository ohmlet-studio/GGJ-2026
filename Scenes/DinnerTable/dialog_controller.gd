@tool
extends Control

@onready var label = $Label
@onready var prompts: Array[DialogPrompt]
@onready var prompts_parent = $Prompts
@onready var minigame: Minigame = %Minigame

@export_range(0, 100, 1) var current_dialog_index: int:
	set(value):
		current_dialog_index = value
		_set_params(value)

func _ready():
	play_prompt(0)

func _convert_sequence(string_sequence: String):
	var string_to_enum = {
		"HAPPY": SimonDirections.UP,
		"SAD": SimonDirections.DOWN,
		"ANGER": SimonDirections.RIGHT,
		"SURPRISED" : SimonDirections.LEFT,
	}
	
	var single_words = string_sequence.split(" ")
	
	var enum_sequence = []
	for word in single_words:
		enum_sequence.append(string_to_enum[word])
	
	return enum_sequence

func _set_params(value):
	prompts.assign(prompts_parent.get_children())
	
	if not prompts_parent:
		return

	if not prompts:
		return
		
	if value < 0 or value >= prompts.size():
		return
	
	var current_prompt = prompts[value]

	if not Engine.is_editor_hint():
		Metronome.tempo_ms = current_prompt.tempo_bpm * 6000.0
	
	minigame.character = current_prompt.character
	
	var sequence = _convert_sequence(current_prompt.input_sequence)
	minigame.npc_sequence = sequence

func _display_text_npc(prompt_number):
	var text_to_display = ""
	text_to_display = prompts[prompt_number].char_dialog
	label.char2char(text_to_display)

func _display_text_player(prompt_number):
	$Label.text = prompts[prompt_number].response

func play_prompt(prompt_number: int):
	current_dialog_index = prompt_number

	print("Displaying text npc")
	_display_text_npc(prompt_number)
	
	print("Waiting 2s")
	await get_tree().create_timer(2.0).timeout
	
	print("Playing npc sequence")
	await minigame.play_sequence_npc()

	print("Waiting 2s")
	await get_tree().create_timer(2.0).timeout

	print("Letting the user play the minigame")
	await minigame.start()
	
	_display_text_player(prompt_number)
	
