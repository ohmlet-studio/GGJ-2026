extends Node2D

var direction_keys = {
	KEY_UP: SimonDirections.UP,
	KEY_DOWN: SimonDirections.DOWN,
	KEY_LEFT: SimonDirections.LEFT,
	KEY_RIGHT: SimonDirections.RIGHT,
	KEY_W: SimonDirections.UP,
	KEY_S: SimonDirections.DOWN,
	KEY_A: SimonDirections.LEFT,
	KEY_D: SimonDirections.RIGHT,
	KEY_Z: SimonDirections.UP,
	KEY_Q: SimonDirections.LEFT,
}

func _input(event: InputEvent) -> void:	
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode in direction_keys:
			var direction = direction_keys[event.keycode]
			%Minigame.press_direction(direction)
