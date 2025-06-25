extends Node
class_name NPCSpeaker

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var phrase_box_target: Node3D

signal spoke(from_location: Node3D, text: String, response_time: float)

var _curr_dialogue_line: DialogueLine

func _process(_delta: float) -> void:
	pass

func on_player_finder_body_entered(_body: Node3D):
	if not _curr_dialogue_line:
		_curr_dialogue_line = await dialogue_resource.get_next_dialogue_line("start")
	else:
		_curr_dialogue_line = await dialogue_resource.get_next_dialogue_line(_curr_dialogue_line.next_id)
	if _curr_dialogue_line:
		var response_time = _curr_dialogue_line.get_tag_value("response_time").to_float()

		spoke.emit(phrase_box_target, _curr_dialogue_line.text, response_time)
