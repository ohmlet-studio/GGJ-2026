extends Node2D

@onready var circle_eg = $CircleExample
@onready var dot_eg = $DotExample
@onready var middle_element = $TheatreMask
@onready var minigame: Minigame = %Minigame

@onready var circle = $Circle
@onready var cross = $Cross

var base_scale_middle

var colors = {
	SimonDirections.UP: Color.YELLOW,
	SimonDirections.DOWN: Color.NAVY_BLUE,
	SimonDirections.LEFT: Color.DARK_GREEN,
	SimonDirections.RIGHT: Color.DARK_RED
}

var next_color

func _ready() -> void:
	Metronome.tick.connect(_on_tick)
	minigame.next_queried_direction.connect(_on_next_queried_direction)
	base_scale_middle = middle_element.scale

var _miss_tween: Tween
var _hit_tween: Tween

func show_miss():
	if _miss_tween:
		_miss_tween.kill()
		
	cross.visible = true
	circle.visible = false

	_miss_tween = create_tween()
	_miss_tween.tween_interval(0.2)
	_miss_tween.tween_callback(
		func():
			cross.visible = false
	)
	
func show_hit():
	if _miss_tween:
		_miss_tween.kill()
		
	cross.visible = false
	circle.visible = true

	_miss_tween = create_tween()
	_miss_tween.tween_interval(0.2)
	_miss_tween.tween_callback(
		func():
			circle.visible = false
	)

func _on_next_queried_direction(direction: int):
	next_color = colors[direction]
	# don't wait for next beat as the signal in called on beat!
	spawn_circle(next_color, Metronome.tempo_ms)

func _on_tick(tempo_ms: int, window_duration_ms: int):
	if next_color:
		next_color = null
	else:
		spawn_dot(Color.hex(0x9483cbFF), tempo_ms)
	
	# tween middle_element in and out on beat
	var tween = create_tween()
	tween.tween_property(middle_element, "scale", base_scale_middle * Vector2(1.1, 1.1), 0.05)
	tween.tween_property(middle_element, "scale", base_scale_middle, 0.075)


func spawn_circle(color: Color, time_ms: float):
	var new_circle = circle_eg.duplicate()
	
	self.add_child(new_circle)
	
	new_circle.time_ms = time_ms
	new_circle.color = color
	new_circle.visible = true # this has the effect of launching it

func spawn_dot(color: Color, time_ms: float):
	var new_dot = dot_eg.duplicate()
	
	self.add_child(new_dot)
	
	new_dot.time_ms = time_ms
	new_dot.color = color
	new_dot.visible = true # this has the effect of launching it


func _process(delta: float) -> void:
	pass
