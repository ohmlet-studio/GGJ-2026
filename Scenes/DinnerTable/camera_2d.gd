extends Camera2D

@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	Metronome.tick.connect(_on_tick)

func _on_tick(tempo_ms, window_duration_ms):
	anim_player.play("PulseZoom")
