@tool
extends Node2D
class_name Minigame

@onready var char_sprite = %CharacterSprite

@export var tempo_ms: float = 200.0
@export var character: CharacterEnum.chars:
	set(value):
		character = value
		_update_character_sprite()

@export var is_npc: bool = false:
	set(value):
		is_npc = value
		_update_character_sprite()

const character_sprites = {
	CharacterEnum.chars.BABY: preload("res://Assets/Characters/baby.png"),
	CharacterEnum.chars.BOB: preload("res://Assets/Characters/bob.png"),
	CharacterEnum.chars.CHILD: preload("res://Assets/Characters/child.png"),
	CharacterEnum.chars.DAD: preload("res://Assets/Characters/dad.png"),          # ← Swap these two
	CharacterEnum.chars.MOM: preload("res://Assets/Characters/mom.png"),          # ← 
	CharacterEnum.chars.OLD_LADY: preload("res://Assets/Characters/old_lady.png"),
	CharacterEnum.chars.PUNK: preload("res://Assets/Characters/punk.png"),
	CharacterEnum.chars.JEANKEVIN: preload("res://Assets/Characters/jean-kevin.png"),
	CharacterEnum.chars.PLAYER: preload("res://Assets/Characters/us.png")
}

var reply_text: String
var character_text: String
var npc_sequence: Array

var reset_timer: Timer

func _ready() -> void:
	reset_timer = Timer.new()
	self.add_child(reset_timer)
	reset_timer.timeout.connect(_on_timer_finished)
	
	_update_character_sprite()  # Update here when everything is ready
	#is_npc = true

func _update_character_sprite():
	if not char_sprite or not is_node_ready():
		return
	var sprite_key = CharacterEnum.chars.PLAYER if not is_npc else character

	if character_sprites.has(sprite_key):
		char_sprite.texture = character_sprites[sprite_key]

func _on_timer_finished():
	$MaskSticks.reset()

func start():
	is_npc = false

func play_sequence_npc():
	for emotion in npc_sequence:
		$MaskSticks.set_mask(emotion)
		reset_timer.start(1.0)
		
		print("displaying emotion: ", emotion)
		await get_tree().create_timer(tempo_ms / 1000.0).timeout

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
