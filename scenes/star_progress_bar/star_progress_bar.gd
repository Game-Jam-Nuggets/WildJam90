class_name StarProgressBar
extends Control

signal progress_changed(new_progress: float, old_progress: float)

@export var uniform_name_progress: StringName = &"progress";
@export var mat_progressive_fill: ShaderMaterial

## progress is a float that ranges from (0, 1).
@export var progress: float:
	set(p_value):
		var old_progress := progress
		progress = p_value
		progress_changed.emit(old_progress, progress)
		if mat_progressive_fill:
			mat_progressive_fill.set_shader_parameter(uniform_name_progress, progress)

func _ready() -> void:
	if mat_progressive_fill:
		mat_progressive_fill.set_shader_parameter(uniform_name_progress, progress)
