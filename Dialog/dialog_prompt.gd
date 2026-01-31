extends Node
class_name DialogPrompt

enum CharacterEnum {KID, GRANDMA, DAD, MOM}

@export_multiline("dialog for this prompt") var dialog_content: String # The aactual dialog
@export var input_sequence: Array[int] # Array[SimonDirections] to input
@export var tempo_ms: float = 0.5 # tempo of the prompt
@export var beat_modulo: int = 1 # 1: every beat, 2: every two beats, ...
@export var character: CharacterEnum
