extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioController.play_music(0, AudioController.MUSIC_SCENE.TITLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$door/SubViewport/Node3D/AnimationPlayer.play("bounce")


func _on_doorbell_pressed() -> void:
	AudioController.play_ding()
	$FadeTransitionManager.fade_out()
	#get_tree().call_deferred("change_scene_to_file", "res://Scenes/DinnerTable/DinnerTable.tscn")


func _on_credits_pressed() -> void:
	$credits_screen.visible = true


func _on_credit_return_pressed() -> void:
	$credits_screen.visible = false
