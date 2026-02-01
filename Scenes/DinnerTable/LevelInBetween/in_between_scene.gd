extends Node2D

@onready var inner_thought_label = $LabelInnerThoughts
@onready var completion_label_pct = $CompletionPercentageLabel
@onready var average_error_ms = $AverageErrorMsLabel
@onready var score_letter = $FinalScoreLetter


signal retry_level()
signal next_level()

func _ready():
	self.visible = false

# Fill labels based on performance data
# @param errors_ms: Array of absolute error values in milliseconds for each note (-1 if missed)
# @param good_thought: Text to show for good performance
# @param bad_thought: Text to show for bad performance
func show_in_between_scene(errors_ms: Array, good_thought: String, bad_thought: String) -> void:
	self.visible = true
	
	var total_notes = errors_ms.size()
	
	# Count hit notes (non -1 values) and collect valid errors
	var hit_notes = 0
	var valid_errors = []
	for error in errors_ms:
		if error >= 0:
			hit_notes += 1
			valid_errors.append(error)
	
	# Calculate completion percentage
	var completion_pct = 0.0
	if total_notes > 0:
		completion_pct = (float(hit_notes) / float(total_notes)) * 100.0
		Globalvar.tot_complt_pct.append(completion_pct)
	completion_label_pct.text = str("%.0f" % completion_pct +" %")
	
	# Calculate average error (only for hit notes)
	var avg_error = 0.0
	if valid_errors.size() > 0:
		var sum = 0.0
		for error in valid_errors:
			sum += error
		avg_error = sum / valid_errors.size()
		Globalvar.tot_average_error.append(avg_error)
	average_error_ms.text = str("%.2f" % avg_error + " ms")
	
	# Determine letter grade based on average error
	# Assuming max acceptable error is around 250ms (half of a typical 500ms window)
	var letter = get_letter_grade(avg_error, 250.0)
	score_letter.text = letter
	
	# Set inner thought based on performance
	# Consider it "good" if average error is less than 100ms and completion is high
	if avg_error < 100.0 and completion_pct > 70.0:
		inner_thought_label.text = good_thought
	else:
		inner_thought_label.text = bad_thought

# Calculate letter grade based on average error
func get_letter_grade(avg_error: float, max_error: float) -> String:
	var normalized_error = clamp(avg_error / max_error, 0.0, 1.0)
	
	# Grade thresholds (lower error = better grade)
	if normalized_error <= 0.15:
		return "A"
	elif normalized_error <= 0.30:
		return "B"
	elif normalized_error <= 0.45:
		return "C"
	elif normalized_error <= 0.60:
		return "D"
	elif normalized_error <= 0.75:
		return "E"
	elif normalized_error <= 0.90:
		return "F"
	else:
		return "G"

func _on_retry_button_pressed() -> void:
	self.visible = false
	retry_level.emit()

func _on_next_level_pressed() -> void:
	self.visible = false
	next_level.emit()
