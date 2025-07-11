extends VBoxContainer
class_name NamedIntSelector

@export var _name_label: Label
@export var _value_spinbox: SpinBox

func init_with(new_name: String, min_value: int, max_value: int) -> void:
	_name_label.text = new_name
	_value_spinbox.step = 1
	_value_spinbox.rounded = true
	_value_spinbox.min_value = min_value
	_value_spinbox.max_value = max_value
	_value_spinbox.value = min_value

func get_value() -> int:
	return _value_spinbox.value as int
