extends Node2D

## SFX arrays
@onready var _sad 	= [$SFX/Sad_sfx_1, $SFX/Sad_sfx_2, $SFX/Sad_sfx_3, $SFX/Sad_sfx_4, $SFX/Sad_sfx_5]
@onready var _happy	= [$SFX/Happy_sfx_1, $SFX/Happy_sfx_2, $SFX/Happy_sfx_3, $SFX/Happy_sfx_4, $SFX/Happy_sfx_5, $SFX/Happy_sfx_6]
@onready var _angry	= [$SFX/Angry_sfx_1, $SFX/Angry_sfx_2, $SFX/Angry_sfx_3, $SFX/Angry_sfx_4, $SFX/Angry_sfx_5, $SFX/Angry_sfx_6]
@onready var _surprised = [$SFX/Surprised_sfx_1, $SFX/Surprised_sfx_2, $SFX/Surprised_sfx_3, $SFX/Surprised_sfx_4, $SFX/Surprised_sfx_5]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## Emotions audio handler
# Public
func play_feelings(direction):
	# Handle sad / happy / angry / surprised
	# with directions
	match direction:
		GlobalEnum.directions.UP:
			_happy.pick_random().play()
		GlobalEnum.directions.DOWN:
			_sad.pick_random().play()
		GlobalEnum.directions.LEFT:
			_surprised.pick_random().play()
		GlobalEnum.directions.RIGHT:
			_angry.pick_random().play()
