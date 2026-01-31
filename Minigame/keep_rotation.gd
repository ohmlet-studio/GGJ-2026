@tool

extends Sprite2D

@export var align: bool = false
@onready var original_rotation = self.global_rotation 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if align:
		self.global_rotation = original_rotation
	else:
		original_rotation = global_rotation
