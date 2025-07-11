extends Control
class_name ResponsePreview

const EvaluationAttribute = preload("res://scripts/player/Evaluation.gd").EvaluationAttribute

@export var sentence_label: RichTextLabel
@export var evaluations_label: RichTextLabel


func init_with(sentense: String, evaluation: Evaluation) -> void:
	sentence_label.text = "[color=gray]You respond: [color=white]" + sentense
	sentence_label.bbcode_enabled = true
	evaluations_label.text = _format_evaluation(evaluation)

func _format_evaluation(evaluation: Evaluation) -> String:
	var formatted_evaluations: String = ""
	for attribute_index in range(EvaluationAttribute.size()):
		var prefix = ""
		var suffix = ""
		if evaluation.get_attribute(attribute_index) < 0:
			prefix = "[color=red]"
		elif evaluation.get_attribute(attribute_index) > 0:
			prefix = "[color=green]"
		suffix = "[color=white]"
		formatted_evaluations += prefix + EvaluationAttribute.keys()[attribute_index] + ": " + str(evaluation.get_attribute(attribute_index)) + "\n" + suffix
	return formatted_evaluations.strip_edges()
