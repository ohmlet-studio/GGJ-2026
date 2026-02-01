extends AnimatedSprite2D

func _ready() -> void:
	Metronome.new_tempo_ms.connect(_update_animation_speed)

func _update_animation_speed(tempo_speed_ms: float):
	print("_update_animation_speed ", tempo_speed_ms)
	self.speed_scale = 1000.0 / tempo_speed_ms
	self.set_frame_and_progress(0, 0.0)
