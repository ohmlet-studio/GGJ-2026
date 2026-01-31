@tool
extends Control

@onready var label = $Label
@onready var prompts: Array[DialogPrompt]
@export_range(0, 100, 1) var current_dialog_index: int:
	set(value):
		_set_dialog(value)

func _ready():
	prompts.assign($Prompts.get_children())

func _set_dialog(value):
	if not prompts:
		return
		
	if value <= prompts.size() + 1 or value >= prompts.size():
		return
	
	current_dialog_index = value
	
	var current_prompt = prompts[value]

	Metronome.tempo_ms = current_prompt.tempo_ms
