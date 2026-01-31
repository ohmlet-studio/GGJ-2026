@tool
extends Node2D

@onready var char_sprite = %CharacterSprite

@export var tempo_bpm: float = 1.0
@export var character: CharacterEnum.chars:
	set(value):
		character = value
		if char_sprite:
			char_sprite.texture = character_sprites[value]
		
var character_sprites = {
	CharacterEnum.chars.BABY: preload("res://Assets/Characters/baby.png"),
	CharacterEnum.chars.BOB: preload("res://Assets/Characters/bob.png"),
	CharacterEnum.chars.CHILD: preload("res://Assets/Characters/child.png"),
	CharacterEnum.chars.MOM: preload("res://Assets/Characters/mom.png"),
	CharacterEnum.chars.DAD: preload("res://Assets/Characters/dad.png"),
	CharacterEnum.chars.OLD_LADY: preload("res://Assets/Characters/old_lady.png"),
	CharacterEnum.chars.PUNK: preload("res://Assets/Characters/punk.png")
}

var reset_timer: Timer

func _ready() -> void:
	reset_timer = Timer.new()

func press_direction(direction):
	$MaskSticks.set_mask(direction)
	
	var camera_anim = %Camera2D.get_node("AnimationPlayer")
	if camera_anim.is_playing():
		camera_anim.stop(false)
	camera_anim.play("PulseZoom")
	
	reset_timer.start(1.0)
