extends PanelContainer
class_name WordBox

@export var _my_rich_text_label: RichTextLabel

var _my_lexicon_entry: LexiconEntry
var _hovered: bool = false
var _grabbed: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func init_with(entry: LexiconEntry) -> void:
	_my_lexicon_entry = entry
	_my_rich_text_label.text = entry.string

func _process(_delta):
	# Change the appearance
	if _hovered:
		self.modulate = Color(1, 1, 0)
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
