extends Node2D

@onready var conductor: AnimationPlayer = $conductor

@export var note_area : Node2D
@export var grouping_positioner : Node2D

var grouping_spawn_pos = Vector2(0,0) # percentage between 0 and 100%

@onready var viewport_size = get_viewport().size

# just putting these here for now
# group loading
const NOTE_GROUP_HORIZONTAL = preload("uid://4xwpiyf7vc0a")
const NOTE_GROUP_VERTICAL = preload("uid://nnfnpxbllb62")
const NOTE_GROUP_DIAG_UP = preload("uid://u8lglrihhur4")
const NOTE_GROUP_DIAG_DOWN = preload("uid://b52y8y2feytq6")
const NOTE_GROUP_CURVE_UP = preload("uid://bv0ay11olua0s")
const NOTE_GROUP_CURVE_DOWN = preload("uid://brewv3vxx0xpu")

# this will need to be able to load a song based upon what is stored and it name under an
# enum, for right now it will just fucking autostart

# EDIT: WE REDOING THIS ENTIRELY

# animations will now be the 4 beats per one second
# this makes it easy for:
# 1. being able to tell where in the music you are when placing beats
# 2. allows for proper scaling of animation when being played

# we will instead adjust anim playback speed to match the bpm, much more simple
# therefore, set all animations to snap at 0.25, and adjust lengths accordingly
# ps. this means length of animation is basically the amount of measures in a song

func _ready():
	Events.level_start.connect(_start_level)
	
	Events.level_selected.emit(Level_Info.LEVEL_NAME.LEVEL_1) # debug

func _start_level(level_info : Level_Info):
	# setup 
	conductor.current_animation = level_info.conductor_anim
	conductor.speed_scale = 0.25 * (Gamestate.current_bpm / 60.0) # scaling animation to the bpm
	
	# music_player.stream = level_info.music_file
	AudioManager.set_music(level_info.music_file, 0.5)
	
	# start
	conductor.play();
	
func _add_group(group : Enums.Groups): # position is by canvas percentage
	#var grouping_spawn_pos = position
	var group_tscn = _fetch_group(group)
	
	var group_instance = group_tscn.instantiate()
	note_area.add_child(group_instance)
	group_instance.global_position = grouping_positioner.position

func _fetch_canvas_pos_by_percent(percent : Vector2):
	return Vector2(viewport_size.x * (percent.x / 100.0), viewport_size.y * (percent.y / 100.0))

func _fetch_group(group_name : Enums.Groups):
	var group_tscn = null
	match group_name:
		Enums.Groups.HORIZONTAL: group_tscn = NOTE_GROUP_HORIZONTAL
		Enums.Groups.VERTICAL: group_tscn = NOTE_GROUP_VERTICAL
		Enums.Groups.DIAG_UP: group_tscn = NOTE_GROUP_DIAG_UP
		Enums.Groups.DIAG_DOWN: group_tscn = NOTE_GROUP_DIAG_DOWN
		Enums.Groups.CURVE_UP: group_tscn = NOTE_GROUP_CURVE_UP
		Enums.Groups.CURVE_DOWN: group_tscn = NOTE_GROUP_CURVE_DOWN
	
	if group_tscn != null: return group_tscn
	else: print_debug("no grouping matching that name?!")
