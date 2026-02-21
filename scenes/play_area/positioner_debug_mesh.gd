extends Node2D

@export var show_positioner = false

func _ready():
	if !Engine.is_editor_hint() && !show_positioner:
		visible = false
