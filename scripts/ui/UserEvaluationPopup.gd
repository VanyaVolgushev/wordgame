extends Control
class_name UserEvaluationPopup

const EvaluationAttribute = preload("res://scripts/player/Evaluation.gd").EvaluationAttribute

@export var _accept_button: Button
@export var _hbox_container: HBoxContainer
@export var _named_int_selector_res: PackedScene
@export var _sentence_label: RichTextLabel

var _evaluation_value_selectors: Array[NamedIntSelector] = []

signal user_evaluation_completed

func init_with_sentence(sentence: String) -> void:
	_sentence_label.text = "[color=gray]Please evaluate the following sentence:\n[color=white]" + sentence + "[color=gray]\nIts evaluation wasn't preloaded. Its evaluation will be stored for future reference."
	# For now, we just set up the evaluation selectors

func _ready():
	_accept_button.pressed.connect(_on_accept_button_pressed)
	for attr_index in EvaluationAttribute.size():
		var selector = _named_int_selector_res.instantiate() as NamedIntSelector
		selector.init_with(EvaluationAttribute.keys()[attr_index], Evaluation.MinAttributeValues[attr_index], Evaluation.MaxAttributeValues[attr_index])
		_evaluation_value_selectors.append(selector)
		_hbox_container.add_child(selector)
		
func _on_accept_button_pressed():
	user_evaluation_completed.emit(_get_evaluation_string())

func _get_evaluation_string() -> String:
	var evaluation_str = ""
	for selector in _evaluation_value_selectors:
		evaluation_str += str(selector.get_value()) + ","
	evaluation_str = evaluation_str.substr(0, evaluation_str.length() - 1)  # Remove the last comma
	return evaluation_str
