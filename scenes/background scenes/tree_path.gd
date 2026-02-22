class_name TreePath
extends Node2D

func _ready() -> void:
	add_to_group("trees")

func get_path_point_count() -> int:
	return get_child_count()

func get_path_position(i: int) -> Vector2:
	assert(i < get_path_point_count())
	var p := get_child(i) as TreePathNode
	return p.global_position

func get_path_scale(i: int) -> Vector2:
	assert(i < get_path_point_count())
	var p := get_child(i) as TreePathNode
	return Vector2(p.tree_scale, p.tree_scale)

func get_path_z_index(i: int) -> int:
	assert(i < get_path_point_count())
	var p := get_child(i) as TreePathNode
	return 0 if p.is_foreground else 1
