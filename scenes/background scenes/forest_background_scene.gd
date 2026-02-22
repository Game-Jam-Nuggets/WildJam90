extends Node2D

func _on_timer_timeout() -> void:
	get_tree().call_group("trees", "move_to_next_path_point")
