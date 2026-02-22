extends Node2D

@export var shade_right: bool
@export var tree_path: TreePath
@export var path_point: int
@export var speed: float
@onready var sprite_2d: Sprite2D = $Sprite2D

var tween: Tween

func _ready() -> void:
	if shade_right:
		sprite_2d.flip_h = true
		
	add_to_group("trees")
	global_position = tree_path.get_path_position(path_point)
	z_index = tree_path.get_path_z_index(path_point)
	scale = tree_path.get_path_scale(path_point)

func move_to_next_path_point() -> void:
	if path_point >= tree_path.get_path_point_count() - 1:
		path_point = 0
		if tween and tween.is_running():
			tween.kill()
			tween = null
		# Snap to the next spot (usually the first)
		global_position = tree_path.get_path_position(path_point)
		z_index = tree_path.get_path_z_index(path_point)
		scale = tree_path.get_path_scale(path_point)
	else:
		path_point = path_point + 1
		z_index = tree_path.get_path_z_index(path_point)
		if tween and tween.is_running():
			tween.kill()
			tween = null
		tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(self, "global_position", tree_path.get_path_position(path_point), speed)
		tween.parallel().tween_property(self, "scale", tree_path.get_path_scale(path_point), speed)
		
