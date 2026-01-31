extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	# change scene
<<<<<<< HEAD
	get_tree().call_deferred("change_scene_to_file", "res://DinnerTable/DinnerTable.tscn")

func _on_credits_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://MainMenu/Credits.tscn")
=======
	get_tree().change_scene_to_file("res://Scenes/DinnerTable/DinnerTable.tscn")

	
>>>>>>> 7df9a7b955f3168509253890358b9f935f8ae1a2
