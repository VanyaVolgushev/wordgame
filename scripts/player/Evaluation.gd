class_name Evaluation

enum EvaluationAttribute { SENSIBILITY, FRIENDLINESS, POLITENESS }

const MaxAttributeValues: Array = [2, 2, 2]  # Max values for each attribute
const MinAttributeValues: Array = [0, -2, -2]  # Min values for each attribute

var _attributes: Array

func _init(attributes: Array[int]) -> void:
	if attributes.size() != EvaluationAttribute.values().size():
		printerr("Error: Attributes size does not match the number of evaluation scales.")
		return
	for i in range(attributes.size()):
		if attributes[i] < MinAttributeValues[i] or attributes[i] > MaxAttributeValues[i]:
			printerr("Error: Attribute value out of bounds for", EvaluationAttribute.values()[i], ":", attributes[i])
			return
	_attributes = attributes

func get_attribute(attr: EvaluationAttribute) -> int:
	return _attributes[attr]
