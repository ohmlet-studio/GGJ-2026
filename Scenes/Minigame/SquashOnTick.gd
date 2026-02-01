extends Sprite2D

@onready var default_scale = self.scale
var recovery_time: float = 0.2
@export var scale_factor = Vector2(1.0, 0.99)

func _ready() -> void:
	Metronome.tick.connect(_on_metronome_tick)

func _on_metronome_tick(_tempo_ms: int, _window_duration_ms: int) -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", default_scale * scale_factor, 0.06).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", default_scale, recovery_time).set_ease(Tween.EASE_OUT)
