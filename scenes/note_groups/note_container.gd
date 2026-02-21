extends Node2D

@export var rotation_speed = 0.0 # rotation around axis

@export var sin_speed = Vector2(0.0, 0.0)
@export var sin_multi = Vector2(1.0, 1.0)

func _physics_process(delta: float) -> void:
	_rotate(delta)
	_wave_move(delta)

func _rotate(delta):
	if rotation_speed == 0.0: return
	
	self.rotation += rotation_speed * delta

func _wave_move(delta):
	if sin_speed == Vector2.ZERO: return

	var sin_increment : Vector2
	sin_increment.x += sin_speed.x * delta
	sin_increment.y += sin_speed.y * delta
	
	self.position.x = sin(sin_increment.x)
	self.position.y = sin(sin_increment.y)
