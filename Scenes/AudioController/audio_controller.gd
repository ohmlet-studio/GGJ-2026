extends Node2D

## SFX arrays
@onready var _sad 	= [$Sad_sfx_1, $Sad_sfx_2, $Sad_sfx_3, $Sad_sfx_4, $Sad_sfx_5]
@onready var _happy	= [$Happy_sfx_1, $Happy_sfx_2, $Happy_sfx_3, $Happy_sfx_4, $Happy_sfx_5, $Happy_sfx_6]
@onready var _angry	= [$Angry_sfx_1, $Angry_sfx_2, $Angry_sfx_3, $Angry_sfx_4, $Angry_sfx_5, $Angry_sfx_6]
@onready var _surprised = [$Surprised_sfx_1, $Surprised_sfx_2, $Surprised_sfx_3, $Surprised_sfx_4, $Surprised_sfx_5]

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
			_happy.pick_random().play()
		SimonDirections.DOWN:
			_sad.pick_random().play()
		SimonDirections.LEFT:
			_angry.pick_random().play()
		SimonDirections.RIGHT:
			_surprised.pick_random().play()
