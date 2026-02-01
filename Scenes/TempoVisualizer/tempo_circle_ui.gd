extends Sprite2D

@export var time_ms: float = 100.0 # how long it takes to reach 0, 0
@export var range_x: float = 30.0 # px, len of the runway
@export var color: Color = Color.WHITE

func _ready() -> void:
	position = Vector2(range_x, position.y)

func _process(delta: float) -> void:
	if visible:
		var pixels_per_second = range_x / (time_ms / 1000.0)
		position.x -= pixels_per_second * delta
		modulate = color
		
		if position.x <= 0:
			_make_semi_transparent()
		
		if position.x <= -range_x:
			queue_free()

func _make_semi_transparent() -> void:
	modulate = Color(color.r, color.g, color.b, 0.3)
