extends Node2D

@onready var direction_sticks = {
	GlobalEnum.directions.UP: $UpStick,
	GlobalEnum.directions.DOWN: $DownStick,
	GlobalEnum.directions.LEFT: $LeftStick,
	GlobalEnum.directions.RIGHT: $RightStick
}

var last_mask

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	self.visible = not get_parent().is_npc

func hide_mask(direction):
	direction_sticks[direction].hide_mask()

func reset():
	for direction in [GlobalEnum.directions.UP, GlobalEnum.directions.DOWN, GlobalEnum.directions.LEFT, GlobalEnum.directions.RIGHT]:
		hide_mask(direction)

func set_mask(direction):
	var current_mask = direction_sticks[direction]
	
	if last_mask:
		if last_mask != current_mask:
			last_mask.hide_mask()
	
	current_mask.show_mask()
		
	last_mask = current_mask
