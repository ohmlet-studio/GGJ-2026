@tool
extends Node2D

@export_range(0, 1000, 1) var tempo_ms: float = 500.0:
	set(value):
		tempo_ms = value
		$GPUParticles2D.lifetime = value / 1000

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
