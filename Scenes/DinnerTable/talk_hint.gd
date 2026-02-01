extends Node2D

@export var visible_hint: CharacterEnum.chars = CharacterEnum.chars.BABY:
	set(value):
		visible_hint = value
		_update_visibility()

@onready var hint_nodes: Dictionary = {
	CharacterEnum.chars.BABY: $Hint_baby,
	CharacterEnum.chars.BOB: $Hint_bob,
	CharacterEnum.chars.JEANKEVIN: $Hint_jeanKev,
	CharacterEnum.chars.MOM: $Hint_mom,
	CharacterEnum.chars.OLD_LADY: $Hint_oldBaby,
	CharacterEnum.chars.PUNK: $Hint_punk,
}

func _ready() -> void:
	_update_visibility()

func _update_visibility() -> void:
	for char_type in hint_nodes:
		var node = hint_nodes[char_type]
		if node:
			node.visible = (char_type == visible_hint)
