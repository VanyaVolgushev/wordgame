extends Node

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var phrase_box_target: Node3D

var _ui: UIManager
var _curr_dialogue_line: DialogueLine

func _process(_delta: float) -> void:
	# This is a workaround to ensure the UIManager is initialized before we try to access it.
	if not _ui:
		_ui = get_tree().get_nodes_in_group("UI")[0] as UIManager

# TODO: NPCDialogue shouldn't own the phrase box scene, UI should create it upon request.
func on_player_finder_body_entered(_body: Node3D):
	if not _curr_dialogue_line:
		_curr_dialogue_line = await dialogue_resource.get_next_dialogue_line("start")
	else:
		_curr_dialogue_line = await dialogue_resource.get_next_dialogue_line(_curr_dialogue_line.next_id)
	if _curr_dialogue_line:
		var response_time = _curr_dialogue_line.get_tag_value("response_time").to_float()
		_ui.create_phrase_box(phrase_box_target, _curr_dialogue_line.text, response_time)
