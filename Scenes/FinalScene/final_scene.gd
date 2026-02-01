extends Control

@onready var av_pct
@onready var av_error


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var inbetween = get_node("res://Scenes/DinnerTable/LevelInBetween/in_between_scene.gd")
	av_pct = inbetween.tot_average_error.reduce(func(a, b): return a + b, 0) / float(inbetween.tot_average_error.size())
	print(av_pct)
	

#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#$av_error_lab.text = 
