extends Node2D

func _process(delta: float) -> void:
	self.visible = not get_parent().is_npc
