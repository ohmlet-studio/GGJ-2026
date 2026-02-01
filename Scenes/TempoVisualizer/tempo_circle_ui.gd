extends Sprite2D

@export var time_ms: float = 100.0 # how long it takes to reach 0, 0
@export var direction: GlobalEnum.directions
@onready var target_node = $"../TheatreMask"
@onready var end_target = $"../EndTarget"
@onready var start_target = $"../StartTarget"

var colors = {
	GlobalEnum.directions.UP: Color.YELLOW,
	GlobalEnum.directions.DOWN: Color.BLUE,
	GlobalEnum.directions.LEFT: Color.GREEN,
	GlobalEnum.directions.RIGHT: Color.RED,
	GlobalEnum.directions.NONE: Color.hex(0x9483cbFF)
}

var rotations = {
	GlobalEnum.directions.UP: 0.0,
	GlobalEnum.directions.DOWN: PI,
	GlobalEnum.directions.LEFT: -PI/2,
	GlobalEnum.directions.RIGHT: PI/2,
	GlobalEnum.directions.NONE: 0.0
}

func _ready() -> void:
	global_position = Vector2(start_target.global_position.x, global_position.y)
	hide()

func _process(delta: float) -> void:
	if visible:
		# distance to go in time_ms
		var range_x = abs(start_target.global_position.x - target_node.global_position.x)

		# speed to reach target_node when speed_s seconds elapsed
		var pixels_per_second = range_x / (time_ms / 1000.0)
		global_position.x -= pixels_per_second * delta
		modulate = colors[direction]
		rotation = rotations[direction]

		if global_position.x <= target_node.global_position.x:
			_make_semi_transparent()

		if global_position.x <= end_target.global_position.x:
			queue_free()

func _make_semi_transparent() -> void:
	var color = colors[direction]
	modulate = Color(color.r, color.g, color.b, 0.3)
