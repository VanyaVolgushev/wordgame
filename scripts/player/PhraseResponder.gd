extends Node
# Responsible for informing 
class_name PhraseResponder

signal phrasebox_in_center()
signal phrasebox_not_in_center()
signal response_began(phrase_box: PhraseBox)
signal response_ended(phrase_box: PhraseBox)

@export var _fps_controller: Node

var _response_target_box: PhraseBox = null

func _ready():
	var UI = get_tree().get_nodes_in_group("UI")[0] as UIManager
	UI.say_button_pressed.connect(_on_say_button_pressed)

func _process(_delta):
	if(_response_target_box == null  && _get_phrasebox_in_center()):
		emit_signal("phrasebox_in_center")
	else:
		emit_signal("phrasebox_not_in_center")

func _get_phrasebox_in_center() -> PhraseBox:
	for pb in get_tree().get_nodes_in_group("Phrase Boxes"):
		if pb is Node and pb.covers_center_of_screen():
			return pb
	return null

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		var phrasebox = _get_phrasebox_in_center()
		if _response_target_box == null && phrasebox:
			_begin_response(phrasebox)
			phrasebox.timeout.connect(_end_response)

func _on_say_button_pressed():
	if _response_target_box:
		_response_target_box.queue_free()
		_end_response()

func _begin_response(phrase_box: PhraseBox) -> void:
	response_began.emit(phrase_box)
	_fps_controller.OnBeginResponse()
	_response_target_box = phrase_box

func _end_response() -> void:
	response_ended.emit(_response_target_box)
	_fps_controller.OnEndResponse()
	_response_target_box = null
