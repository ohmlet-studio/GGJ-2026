@tool
extends Node2D

@onready var char_sprite = %CharacterSprite

@export var tempo_ms: float = 200.0
@export var character: CharacterEnum.chars:
	set(value):
		character = value
		if char_sprite:
			char_sprite.texture = character_sprites[value]

@export var is_npc: bool = false

var character_sprites = {
	CharacterEnum.chars.BABY: preload("res://Assets/Characters/baby.png"),
	CharacterEnum.chars.BOB: preload("res://Assets/Characters/bob.png"),
	CharacterEnum.chars.CHILD: preload("res://Assets/Characters/child.png"),
	CharacterEnum.chars.MOM: preload("res://Assets/Characters/mom.png"),
	CharacterEnum.chars.DAD: preload("res://Assets/Characters/dad.png"),
	CharacterEnum.chars.OLD_LADY: preload("res://Assets/Characters/old_lady.png"),
	CharacterEnum.chars.PUNK: preload("res://Assets/Characters/punk.png"),
	CharacterEnum.chars.JEANKEVIN: preload("res://Assets/Characters/jean-kevin.png")
}

var reset_timer: Timer

func _ready() -> void:
	reset_timer = Timer.new()
	self.add_child(reset_timer)
	reset_timer.finished.connect(_on_timer_finished)
	
	is_npc = true

func _on_timer_finished():
	$MaskSticks.reset()

func play_sequence_npc(sequence: Array[int]):
	for emotion in sequence:
		$MaskSticks.set_mask(emotion)
		reset_timer.start(1.0)
		
		await get_tree().create_timer(tempo_ms).timeout
		
	return true

func press_direction(direction):
	if is_npc:
		return
		
	$MaskSticks.set_mask(direction)
	# SFX handle
	AudioController.play_feelings(direction)
	
	var camera_anim = %Camera2D.get_node("AnimationPlayer")
	if camera_anim.is_playing():
		camera_anim.stop(false)
	camera_anim.play("PulseZoom")
		
	reset_timer.start(1.0)
