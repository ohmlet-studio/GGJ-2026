extends Node
class_name DialogPrompt

## Dialogue du membre de la famille
@export_multiline("dialog for this prompt") var char_dialog: String # The aactual dialog

## Réponse du perso principal
@export_multiline("the character response") var response: String # The response

## Séquence à entrer pour valider l'intéraction eg: "HAPPY SAD ANGER SURPRISE"
@export_multiline var input_sequence: String

## le tempo de la musique
@export_range(60, 1200) var tempo_bpm: int = 600 # tempo of the prompt

## sur quel beat on doit faire l'input (1: every beat, 2: every two beats, ...)
@export var beat_modulo: int = 1

## quel perso, duh
@export var character: CharacterEnum.chars
