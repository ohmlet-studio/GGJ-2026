@tool
extends Node2D
class_name Minigame

@onready var char_sprite = %CharacterSprite

@export var tempo_ms: float = 200.0
@export var character: GlobalEnum.chars:
	set(value):
		character = value
		_update_character_sprite()

@export var is_npc: bool = false:
	set(value):
		is_npc = value
		_update_character_sprite()

signal next_queried_direction(direction: int)

signal finished_sequence_player()
signal input_valid(offset_ms: float)
signal input_invalid(offset_ms: float)
signal input_missed()

const character_sprites = {
	GlobalEnum.chars.BABY: preload("res://Assets/Characters/baby.png"),
	GlobalEnum.chars.BOB: preload("res://Assets/Characters/bob.png"),
	GlobalEnum.chars.CHILD: preload("res://Assets/Characters/child.png"),
	GlobalEnum.chars.DAD: preload("res://Assets/Characters/dad.png"),          # ← Swap these two
	GlobalEnum.chars.MOM: preload("res://Assets/Characters/mom.png"),          # ← 
	GlobalEnum.chars.OLD_LADY: preload("res://Assets/Characters/old_lady.png"),
	GlobalEnum.chars.PUNK: preload("res://Assets/Characters/punk.png"),
	GlobalEnum.chars.JEANKEVIN: preload("res://Assets/Characters/jean-kevin.png"),
	GlobalEnum.chars.PLAYER: preload("res://Assets/Characters/us.png")
}

var reply_text: String
var character_text: String
var npc_sequence: Array
var current_step_in_sequence_player: int = 0 # the step in the sequence for the player

var reset_timer: Timer
var input_window_timer: Timer

func _ready() -> void:
	reset_timer = Timer.new()
	input_window_timer = Timer.new()
	input_window_timer.one_shot = true
	
	self.add_child(reset_timer)
	self.add_child(input_window_timer)

	reset_timer.timeout.connect(_on_timer_finished)
	input_window_timer.timeout.connect(_on_window_missed)
	
	_update_character_sprite()  # Update here when everything is ready
	
	is_npc = true

func _update_character_sprite():
	if not char_sprite or not is_node_ready():
		return
	var sprite_key = GlobalEnum.chars.PLAYER if not is_npc else character

	if character_sprites.has(sprite_key):
		char_sprite.texture = character_sprites[sprite_key]

func _check_if_input_matches_sequence(direction):
	if input_window_timer.time_left > 0: # if timer is running we are in the window
		var time_offset_ms = (input_window_timer.wait_time - input_window_timer.time_left) * 1000
		if current_step_in_sequence_player >= len(npc_sequence):
			return
		
		if direction == npc_sequence[current_step_in_sequence_player]:
			self.input_valid.emit(time_offset_ms)
		else:
			self.input_invalid.emit(time_offset_ms)
		
		input_window_timer.stop() # stop the timer, the window iis nw not valid

func _on_window_missed():
	self.input_missed.emit()

func _on_timer_finished():
	$MaskSticks.reset()

func start_player_turn():
	is_npc = false
	current_step_in_sequence_player = 0
	
	await Metronome.tick

	next_queried_direction.emit(npc_sequence[current_step_in_sequence_player])
	
	await Metronome.pretick
	
	for direction in npc_sequence:
		if current_step_in_sequence_player + 1 < npc_sequence.size() :
			next_queried_direction.emit(npc_sequence[current_step_in_sequence_player + 1])
			
		input_window_timer.start(Metronome.window_duration_ms / 1000.0)
		await Metronome.pretick
		current_step_in_sequence_player += 1
	
	is_npc = true
	
	await Metronome.tick
	
	finished_sequence_player.emit()

func play_sequence_npc():
	for emotion in npc_sequence:
		await Metronome.tick  # wait for the next tick
		
		$MaskSticks.set_mask(emotion)
		reset_timer.start(1.0)
		print("displaying emotion on npc: ", emotion)

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
