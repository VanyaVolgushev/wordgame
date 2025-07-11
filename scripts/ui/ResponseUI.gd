extends Control
class_name ResponseUI

@export var _word_box_res: PackedScene
@export var _say_button: Button
@export var _response_area: Control
@export var _response_preview_res: PackedScene

var _word_boxes: Array[WordBox]

signal say_button_pressed()

func _ready():
	var lexicon = LexiconManager.get_lexicon()
	var word_count = lexicon.size()
	var word_index = 0
	for word in lexicon:
		var word_box = _word_box_res.instantiate() as WordBox
		word_box.init_with(word, _response_area.get_rect())
		word_box.position += Vector2(word_box.size.x * word_index - (word_box.size.x * word_count / 2), 0) + Vector2(0, size.y / 2)
		add_child(word_box)
		_word_boxes.append(word_box)
		word_index += 1
	_say_button.pressed.connect(_on_say_button_pressed)

func _on_say_button_pressed():
	say_button_pressed.emit()

# TODO: break up into smaller functions
func finalize_response() -> String:
	var response: String = ""
	var boxes_inside_response_area: Array[WordBox] = []
	for word_box in _word_boxes:
		if word_box.in_response_area():
			boxes_inside_response_area.append(word_box)
	boxes_inside_response_area.sort_custom(func(a, b): return a.position.x < b.position.x)
	for word_box in boxes_inside_response_area:
		response += word_box.get_word() + " "
	response = response.strip_edges()

	for child in get_children():
		child.queue_free()

	var response_preview = _response_preview_res.instantiate()
	response_preview.init_with(response, await SentenceEvaluator.get_evaluation(response))
	add_child(response_preview)

	# Set up self for freeing after a delay
	var timer = Timer.new()
	timer.wait_time = 5.0
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.timeout.connect(self.queue_free)
	return response
