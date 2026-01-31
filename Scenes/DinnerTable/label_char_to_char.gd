@tool
extends Label

var char_display_speed = 0.05 #seconds

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func char2char(text: String):
	$Label.text= ""
	
	for i in range(text.length()):
		$Label.text += text[i]
		await get_tree().create_timer(char_display_speed).timeout
