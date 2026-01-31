@tool
extends Control

@onready var label = $Label
@onready var prompts: Array[DialogPrompt]
@onready var prompts_parent = $Prompts

@export_range(0, 100, 1) var current_dialog_index: int:
	set(value):
		current_dialog_index = value
		_set_dialog(value)

func _set_dialog(value):
	if not prompts_parent:
		return
	
	prompts.assign(prompts_parent.get_children())

	print(prompts)

	if not prompts:
		return
		
	if value < 0 or value >= prompts.size():
		return
	
	var current_prompt = prompts[value]

	if not Engine.is_editor_hint():
		Metronome.tempo_ms = current_prompt.tempo_ms
		
	label.text = current_prompt.dialog_content
