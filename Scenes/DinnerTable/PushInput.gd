extends Node2D

var direction_keys = {
	KEY_UP: GlobalEnum.directions.UP,
	KEY_DOWN: GlobalEnum.directions.DOWN,
	KEY_LEFT: GlobalEnum.directions.LEFT,
	KEY_RIGHT: GlobalEnum.directions.RIGHT,
	KEY_W: GlobalEnum.directions.UP,
	KEY_S: GlobalEnum.directions.DOWN,
	KEY_A: GlobalEnum.directions.LEFT,
	KEY_D: GlobalEnum.directions.RIGHT,
	KEY_Z: GlobalEnum.directions.UP,
	KEY_Q: GlobalEnum.directions.LEFT,
}

func _input(event: InputEvent) -> void:	
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode in direction_keys:
			var direction = direction_keys[event.keycode]
			%Minigame.press_direction(direction)
