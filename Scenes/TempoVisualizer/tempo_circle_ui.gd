extends Sprite2D

@export var time_ms: float = 100.0 # how long it takes to reach 0, 0
@export var range_x: float = 30.0 # px, len of the runway
@export var direction: GlobalEnum.directions

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
	GlobalEnum.directions.LEFT: PI/2,
	GlobalEnum.directions.RIGHT: -PI/2,
	GlobalEnum.directions.NONE: 0.0
}

func _ready() -> void:
	position = Vector2(range_x, position.y)
	hide()

func _process(delta: float) -> void:
	if visible:
		var pixels_per_second = range_x / (time_ms / 1000.0)
		position.x -= pixels_per_second * delta
		modulate = colors[direction]
		rotation = rotations[direction]
		
		if position.x <= 0:
			_make_semi_transparent()
		
		if position.x <= -range_x:
			queue_free()

func _make_semi_transparent() -> void:
	var color = colors[direction]
	modulate = Color(color.r, color.g, color.b, 0.3)
