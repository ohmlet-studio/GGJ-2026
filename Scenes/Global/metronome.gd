extends Sprite2D

var tempo_ms = 300.0 # the global tempo in ms
var window_duration_ms = 200.0 # duration of the timing window

signal tick(duration: float)

var _timer: Timer

func _ready() -> void:
	_timer = Timer.new()
	_timer.wait_time = tempo_ms / 1000.0
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)
	_timer.start()

func _on_timer_timeout() -> void:
	tick.emit(tempo_ms)
