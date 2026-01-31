extends Node
class_name DialogPrompt

@export_multiline("dialog for this prompt") var char_dialog: String # The aactual dialog
@export_multiline("the character response") var response: String # The response

@export var input_sequence: Array[int] # Array[SimonDirections] to input
@export var tempo_ms: float = 0.5 # tempo of the prompt
@export var beat_modulo: int = 1 # 1: every beat, 2: every two beats, ...
@export var character: CharacterEnum.chars
