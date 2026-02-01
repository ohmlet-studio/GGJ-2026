@tool

extends Label

@export var character_name: GlobalEnum.chars

var character_name_lut = {
	GlobalEnum.chars.BABY: "Baby",
	GlobalEnum.chars.BOB: "Bob",
	GlobalEnum.chars.CHILD: "Child",
	GlobalEnum.chars.DAD: "Dad",
	GlobalEnum.chars.MOM: "Mom",
	GlobalEnum.chars.OLD_LADY: "Old Lady",
	GlobalEnum.chars.PUNK: "Punk",
	GlobalEnum.chars.JEANKEVIN: "Jean-Kévin",
	GlobalEnum.chars.PLAYER: "Me"
}

func _set_name():
	self.text = character_name_lut[character_name]

func _process(delta: float) -> void:
	_set_name()
