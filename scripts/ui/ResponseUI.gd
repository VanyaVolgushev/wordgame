extends Control
class_name ResponseUI

@export var _word_box_res: PackedScene
@export var _say_button: Button

signal say_button_pressed()

func _ready():
	var lexicon = LexiconManager.get_lexicon()
	var word_count = lexicon.size()
	var word_index = 0
	for word in lexicon:
		var word_box = _word_box_res.instantiate() as WordBox
		word_box.init_with(word)
		word_box.position += Vector2(word_box.size.x * word_index - (word_box.size.x * word_count / 2), 0)
		add_child(word_box)
		word_index += 1
	_say_button.pressed.connect(_on_say_button_pressed)

func _on_say_button_pressed():
	say_button_pressed.emit()
	
