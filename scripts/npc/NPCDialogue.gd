extends Node

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var phrase_box_target: Node3D

var ui: UIManager
var curr_dialogue_line: DialogueLine

func update(_delta: float) -> void:
	# This is a workaround to ensure the UIManager is initialized before we try to access it.
	if not ui:
		ui = get_tree().get_nodes_in_group("UI")[0] as UIManager

# TODO: NPCDialogue shouldn't own the phrase box scene, UI should create it upon request.
func on_player_finder_body_entered(_body: Node3D):
	if not curr_dialogue_line:
		curr_dialogue_line = await DialogueManagerAddon.get_next_dialogue_line(dialogue_resource, dialogue_start)
	else:
		curr_dialogue_line = await DialogueManagerAddon.get_next_dialogue_line(dialogue_resource, curr_dialogue_line.next)