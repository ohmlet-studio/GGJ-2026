extends Sprite2D

var rotation_timing = 0.5
@onready var initial_rotation = self.rotation

var tween: Tween

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_mask():
	tween = create_tween()
	tween.tween_property(self, "rotation", initial_rotation, rotation_timing)

func show_mask():
	if tween:
		if tween.is_running():
			tween.stop()
	
	self.rotation = initial_rotation + PI
