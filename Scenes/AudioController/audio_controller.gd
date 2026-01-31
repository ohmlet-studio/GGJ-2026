extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## Emotions audio handler
# Public
func play_feelings(direction):
	# Handle sad / happy / angry / surprised
	# with directions
	match direction:
		SimonDirections.UP:
			$Happy_sfx.play()
		SimonDirections.DOWN:
			$Sad_sfx.play()
		SimonDirections.LEFT:
			$Angry_sfx.play()
		SimonDirections.RIGHT:
			$Surprised_sfx.play()
