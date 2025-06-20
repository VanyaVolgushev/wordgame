extends Node
class_name UIManager

@export var speak_icon: TextureRect
@export var phrase_box: PackedScene

func on_phrasebox_in_center() -> void:
	speak_icon.visible = true

func on_phrasebox_not_in_center() -> void:
	speak_icon.visible = false

func create_phrase_box(target: Node3D, text: String) -> void:
	var phrase_box_instance = phrase_box.instantiate() as Node
	phrase_box_instance.init(target, text)
	add_child(phrase_box_instance)
