extends Panel

@export var label: Label

func _ready():
    size = label.get_minimum_size()