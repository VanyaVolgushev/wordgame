extends PanelContainer
class_name WordBox

@export var _my_rich_text_label: RichTextLabel

var _my_word: String
var _hovered: bool = false
var _grabbed: bool = false

var _response_area: Rect2

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func init_with(word: String, response_area: Rect2) -> void:
	_my_word = word
	_my_rich_text_label.text = word
	_response_area = response_area

func in_response_area() -> bool:
	var left_upper_inside = _response_area.has_point(position)
	var left_lower_inside = _response_area.has_point(position + Vector2(0, size.y))
	var right_upper_inside = _response_area.has_point(position + Vector2(size.x, 0))
	var right_lower_inside = _response_area.has_point(position + size)
	return left_upper_inside or left_lower_inside or right_upper_inside or right_lower_inside

func get_word() -> String:
	return _my_word

func _process(_delta):
	# Change the appearance
	if _hovered:
		self.modulate = Color(1, 1, 0)
	elif in_response_area():
		self.modulate = Color(0, 1, 0)
	else:
		self.modulate = Color(1, 1, 1)

func _gui_input(event):
	if (event is InputEventMouseMotion and _hovered and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) or (event is InputEventMouseMotion and _grabbed):
		position += event.relative
		_grabbed = true
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			_grabbed = true
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
		_grabbed = false

func _on_mouse_entered() -> void:
	_hovered = true

func _on_mouse_exited() -> void:
	_hovered = false
