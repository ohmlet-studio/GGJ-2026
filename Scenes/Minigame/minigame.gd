@tool
extends Node2D
class_name Minigame

@onready var char_sprite = %CharacterSprite

@export var tempo_ms: float = 200.0
@export var character: CharacterEnum.chars:
	set(value):
		character = value
		if char_sprite:
			char_sprite.texture = character_sprites[value]

@export var is_npc: bool = false

signal finished_sequence_player()
signal input_valid(offset_ms: float)
signal input_invalid(offset_ms: float)
signal input_missed()

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

var reply_text: String
var character_text: String
var npc_sequence: Array
var step_in_sequence_player: int = 0 # the step in the sequence for the player

var reset_timer: Timer
var input_window_timer: Timer

func _ready() -> void:
	reset_timer = Timer.new()
	input_window_timer = Timer.new()
	
	self.add_child(reset_timer)
	self.add_child(input_window_timer)

	reset_timer.timeout.connect(_on_timer_finished)
	input_window_timer.timeout.connect(_on_window_missed)
	
	Metronome.tick.connect(_on_metronome_tick)
	
	is_npc = true

func _on_metronome_tick(window_duration_ms: int):
	if is_npc:
		return # we don't do anything if this is not the player
	
	print("metronome_tick")
	
	if step_in_sequence_player == npc_sequence.size():
		finished_sequence_player.emit()
		return
		

	# create a timer for window_duration_ms
	print("starting timer for window duration_ms: ", window_duration_ms)
	input_window_timer.start(window_duration_ms / 1000.0)

	step_in_sequence_player += 1

func _check_if_input_matches_sequence(direction):
	if input_window_timer.time_left > 0: # if timer is running we are in the window
		var time_offset_ms = (input_window_timer.wait_time - input_window_timer.time_left) * 1000
		if direction == npc_sequence[step_in_sequence_player]:
			# input is valid
			self.input_valid.emit(time_offset_ms)
		else:
			# input is on time but not valid
			self.input_valid.emit(time_offset_ms)

		input_window_timer.stop()

func _on_window_missed():
	print("timer window elapsed")
	self.input_missed.emit()

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
	
	_check_if_input_matches_sequence(direction)
	
	reset_timer.start(1.0)
