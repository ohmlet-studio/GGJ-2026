extends AnimatedSprite2D

func _ready() -> void:
	Metronome.new_tempo_ms.connect(_update_animation_speed)

func _update_animation_speed(tempo_speed_ms: float):
	self.speed_scale = 1000.0 / tempo_speed_ms
