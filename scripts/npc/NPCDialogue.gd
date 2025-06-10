extends Node

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var phrase_box_scene: PackedScene
@export var phrase_box_target: Node3D

func on_player_finder_body_entered(_body: Node3D):
	var dialogue_line = await DialogueManagerAddon.get_next_dialogue_line(dialogue_resource, dialogue_start)
	var phrase_box = phrase_box_scene.instantiate()
	phrase_box.init(phrase_box_target, dialogue_line.text)
	UIManager.ui_instance.add_child(phrase_box)
