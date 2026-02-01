extends Sprite2D

signal pretick(tempo_ms: int, window_duration_ms: float)
signal tick(tempo_ms: int, window_duration_ms: float)
signal new_tempo_ms(tempo_ms: float)

var tempo_ms = 1000.0:
	set(value):
		tempo_ms = value
		_timer.wait_time = value / 1000.0
		new_tempo_ms.emit(value)

var window_duration_ms = 150.0

var _timer: Timer
var _pretick_timer: Timer

func _ready() -> void:
	_timer = Timer.new()
	_timer.wait_time = tempo_ms / 1000.0
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)
	
	_pretick_timer = Timer.new()
	_pretick_timer.one_shot = true
	_pretick_timer.timeout.connect(_on_pretick_timeout)
	add_child(_pretick_timer)
	
	_timer.start()
	_schedule_pretick()

func _schedule_pretick():
	# pretick is half a window before the next tick
	var pretick_delay = (tempo_ms - window_duration_ms / 2.0) / 1000.0
	if pretick_delay > 0:
		_pretick_timer.start(pretick_delay)

func set_tempo_bpm(value: int):
	self.tempo_ms = 60000.0 / value
	
func get_tempo_bpm():
	return (60/self.tempo_ms) * 1000

func _on_pretick_timeout() -> void:
	pretick.emit(tempo_ms, window_duration_ms)

func _on_timer_timeout() -> void:
	tick.emit(tempo_ms, window_duration_ms)
	_schedule_pretick()
