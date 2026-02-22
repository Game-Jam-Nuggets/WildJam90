extends GPUParticles2D
var star_cursor = load("res://assets/visual/ui/cursor.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(star_cursor)
	
	# Make sure to reset it to Input.set_custom_mouse_cursor() for the menu
	
func _process(delta: float) -> void:
	
	var offset = Vector2(14,14)
	position = get_viewport().get_mouse_position() + offset

func _exit_tree() -> void:
	Input.set_custom_mouse_cursor(null)
	
	
