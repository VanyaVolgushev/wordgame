extends Node

@export var ui_scene: PackedScene = preload("res://scenes/ui/UI.tscn")
var ui_instance: Node

func _ready():
	ui_instance = ui_scene.instantiate()
	add_child(ui_instance)
