extends Node2D

@export var feedback_time: float = 0.1

@onready var direction_nodes = {
	SimonDirections.UP: $UP,
	SimonDirections.DOWN: $DOWN,
	SimonDirections.LEFT: $LEFT,
	SimonDirections.RIGHT: $RIGHT
}

var original_scale = Vector2.ONE

var active_tweens: Dictionary = {}  # Track tweens per direction

func light_up(direction):
	var node = direction_nodes[direction]

	if active_tweens.has(direction) and active_tweens[direction] != null:
		active_tweens[direction].kill()
	
	var original_color = node.get_meta("original_color")
	
	node.modulate = Color.WHITE
	node.scale = original_scale * 1.2
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(node, "scale", original_scale, feedback_time)
	tween.tween_property(node, "modulate", original_color, feedback_time)
	
	active_tweens[direction] = tween
