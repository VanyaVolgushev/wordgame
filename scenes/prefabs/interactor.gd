extends Node

@export var camera: Camera3D

signal phrasebox_in_center()
signal phrasebox_not_in_center()

func _process(_delta):
    if(any_phrasebox_in_center()):
        emit_signal("phrasebox_in_center")
    else:
        emit_signal("phrasebox_not_in_center")


func any_phrasebox_in_center() -> bool:
    for pb in get_tree().get_nodes_in_group("Phrase Boxes"):
        if pb is Node and pb.covers_center_of_screen():
            return true
    return false
    