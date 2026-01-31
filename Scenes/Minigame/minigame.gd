extends Node2D

@export var tempo_bpm: float = 1.0

func press_direction(direction):
	$MaskSticks.set_mask(direction)
	
	var camera_anim = %Camera2D.get_node("AnimationPlayer")
	if camera_anim.is_playing():
		camera_anim.stop(false)
	camera_anim.play("PulseZoom")
