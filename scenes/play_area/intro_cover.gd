extends Node2D

@onready var intro_animation: AnimationPlayer = $intro_animation

func _ready():
	intro_animation.play("intro")
