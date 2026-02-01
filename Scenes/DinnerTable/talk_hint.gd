extends Node2D

@export var visible_hint: GlobalEnum.chars = GlobalEnum.chars.BABY:
	set(value):
		visible_hint = value
		_update_visibility()

@onready var hint_nodes: Dictionary = {
	GlobalEnum.chars.BABY: $Hint_baby,
	GlobalEnum.chars.BOB: $Hint_bob,
	GlobalEnum.chars.JEANKEVIN: $Hint_jeanKev,
	GlobalEnum.chars.MOM: $Hint_mom,
	GlobalEnum.chars.OLD_LADY: $Hint_oldBaby,
	GlobalEnum.chars.PUNK: $Hint_punk,
}

func _ready() -> void:
	_update_visibility()

func _update_visibility() -> void:
	for char_type in hint_nodes:
		var node = hint_nodes[char_type]
		if node:
			node.visible = (char_type == visible_hint)
