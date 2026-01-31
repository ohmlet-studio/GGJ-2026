extends Node2D

@onready var direction_sticks = {
	SimonDirections.UP: $UpStick,
	SimonDirections.DOWN: $DownStick,
	SimonDirections.LEFT: $LeftStick,
	SimonDirections.RIGHT: $RightStick
}

var last_mask

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func hide_mask(direction):
	direction_sticks[direction].hide_mask()

func reset():
	for direction in [SimonDirections.UP, SimonDirections.DOWN, SimonDirections.LEFT, SimonDirections.RIGHT]:
		hide_mask(direction)

func set_mask(direction):
	var current_mask = direction_sticks[direction]
	
	if last_mask:
		if last_mask != current_mask:
			last_mask.hide_mask()
	
	current_mask.show_mask()
		
	last_mask = current_mask
