extends Node

# Rule: no script should know about the existence of UIManager, only emit ui signals
class_name UIManager

@export var speak_icon: TextureRect
@export var phrase_box: PackedScene

var _phrase_responder: Interactor

func _ready():
	_connect_npc_dialogues()
	get_tree().connect("node_added", _on_node_added)

func _connect_npc_dialogues():
	var npc_dialogues = get_tree().get_nodes_in_group("NPCSpeakers")
	for npc in npc_dialogues:
		if not npc.is_connected("spoke", _on_spoke):
			npc.connect("spoke", _on_spoke)

func _on_node_added(node):
	if node.is_in_group("NPCSpeakers"):
		if not node.is_connected("spoke", _on_spoke):
			node.connect("spoke", _on_spoke)

func _process(_delta):
	if not _phrase_responder:
		var _phrase_responders = get_tree().get_nodes_in_group("PhraseResponder")
		if _phrase_responders.size() > 0:
			_phrase_responder = _phrase_responders[0] as Interactor
			_phrase_responder.phrasebox_in_center.connect(_on_phrasebox_in_center)
			_phrase_responder.phrasebox_not_in_center.connect(_on_phrasebox_not_in_center)
			_phrase_responder.response_began.connect(on_begin_response)
			_phrase_responder.response_ended.connect(on_end_response)

func _on_phrasebox_in_center() -> void:
	speak_icon.visible = true

func _on_phrasebox_not_in_center() -> void:
	speak_icon.visible = false

func on_begin_response() -> void:
	pass

func on_end_response() -> void:
	pass

func _on_spoke(from_location: Node3D, text: String, response_time: float) -> void:
	# This function is called when a dialogue line is spoken
	# It should create a phrase box for the player to respond to
	_create_phrase_box(from_location, text, response_time)

func _create_phrase_box(target: Node3D, text: String, response_time: float) -> void:
	var phrase_box_instance = phrase_box.instantiate() as Node
	phrase_box_instance.init(target, text, response_time)
	add_child(phrase_box_instance)
