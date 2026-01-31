extends Sprite2D

signal tick(duration: float)
signal new_tempo_ms(tempo_ms: float)

# the global tempo in ms
var tempo_ms = 300.0:
	set(value):
		tempo_ms = value
		new_tempo_ms.emit(value)

var window_duration_ms = 200.0 # duration of the timing window


var _timer: Timer

func _ready() -> void:
	_timer = Timer.new()
	_timer.wait_time = tempo_ms / 1000.0
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)
	_timer.start()

func set_tempo_bpm(value: int):
	self.tempo_ms = 60000.0 / value

func _on_timer_timeout() -> void:
	tick.emit(tempo_ms)
