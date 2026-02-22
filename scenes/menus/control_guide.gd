extends TextureRect
class_name ControlGuide

var next_level: Level_Info.LEVEL_ID

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func start_transition(new_next_level: Level_Info.LEVEL_ID) -> void:
	# Set next_level
	next_level = new_next_level
	
	# Stop music
	AudioManager.stop_music()
	
	# Play animation
	animation_player.play("guide_transition")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func goto_level():
	Events.level_selected.emit(next_level)
