extends Node
class_name UIManager

@export var speak_icon: TextureRect
@export var phrase_box: PackedScene

var _player_interactor: Interactor

func _process(_delta):
	if not _player_interactor:
		var _player_interactors = get_tree().get_nodes_in_group("Interactor")
		if _player_interactors.size() > 0:
			_player_interactor = _player_interactors[0] as Interactor
			_player_interactor.phrasebox_in_center.connect(_on_phrasebox_in_center)
			_player_interactor.phrasebox_not_in_center.connect(_on_phrasebox_not_in_center)

func _on_phrasebox_in_center() -> void:
	speak_icon.visible = true

func _on_phrasebox_not_in_center() -> void:
	speak_icon.visible = false

func create_phrase_box(target: Node3D, text: String, response_time: float) -> void:
	var phrase_box_instance = phrase_box.instantiate() as Node
	phrase_box_instance.init(target, text, response_time)
	add_child(phrase_box_instance)
