extends Node2D

@onready var conductor: AnimationPlayer = $conductor

@export var note_area : Node2D
@export var grouping_positioner_0 : Node2D
@export var grouping_positioner_1 : Node2D
@export var grouping_positioner_2 : Node2D

var grouping_spawn_pos = Vector2(0,0) # percentage between 0 and 100%

@onready var viewport_size = get_viewport().size

# just putting these here for now
# group loading
const NOTE_GROUP_SNAKE = preload("uid://ds4fwlp5o7gl2")
const NOTE_GROUP_CURVE = preload("uid://cytqih3j3bqwn")
const NOTE_GROUP_CURVESMALL = preload("uid://c1n570fjnsw4y")
const NOTE_GROUP_SINGLE_BONUS = preload("uid://cryc3yhr40dj1")
const NOTE_GROUP_CIRCLE_ROTATE = preload("uid://bqwa6b0b3c4je")
const NOTE_GROUP_STRAIGHT = preload("uid://bw1odoph8dl6i")

const NOTE_GROUP_BIG_DIPPER = preload("uid://dvsymbgqr4b01")

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

func _start_level(level_info : Level_Info):
	# setup 
	conductor.current_animation = level_info.conductor_anim
	conductor.speed_scale = 0.25 * (Gamestate.current_bpm / 60.0) # scaling animation to the bpm
	
	# music_player.stream = level_info.music_file
	AudioManager.set_music(level_info.music_file, 0.5, 1.0, Gamestate.debug_start_time)
	
	# start
	
	conductor.play()
	conductor.pause()
	conductor.advance(Gamestate.debug_start_time)
	conductor.play()
	
func _add_group(group : Enums.Groups, positioner_index : int): # position is by canvas percentage
	#var grouping_spawn_pos = position
	var group_tscn = _fetch_group(group)
	
	var group_instance = group_tscn.instantiate()
	note_area.add_child(group_instance)
	var current_positioner = null
	match positioner_index:
		0: current_positioner = grouping_positioner_0
		1: current_positioner = grouping_positioner_1
		2: current_positioner = grouping_positioner_2
	
	group_instance.global_position = current_positioner.position
	group_instance.global_rotation = current_positioner.rotation

func _add_group_special(group : Enums.Groups, positioner_index : int): # position is by canvas percentage
	#var grouping_spawn_pos = position
	var group_tscn = _fetch_group_special(group)
	
	var group_instance = group_tscn.instantiate()
	note_area.add_child(group_instance)
	var current_positioner = null
	match positioner_index:
		0: current_positioner = grouping_positioner_0
		1: current_positioner = grouping_positioner_1
		2: current_positioner = grouping_positioner_2
	
	group_instance.global_position = current_positioner.position
	group_instance.global_rotation = current_positioner.rotation


#func _fetch_canvas_pos_by_percent(percent : Vector2):
	#return Vector2(viewport_size.x * (percent.x / 100.0), viewport_size.y * (percent.y / 100.0))

func _fetch_group(group_name : Enums.Groups):
	var group_tscn = null
	match group_name:
		Enums.Groups.SNAKE: group_tscn = NOTE_GROUP_SNAKE
		Enums.Groups.CURVE: group_tscn = NOTE_GROUP_CURVE
		Enums.Groups.CURVE_SMALL: group_tscn = NOTE_GROUP_CURVESMALL
		Enums.Groups.SINGLE_BONUS: group_tscn = NOTE_GROUP_SINGLE_BONUS
		Enums.Groups.CIRCLE_ROTATE: group_tscn = NOTE_GROUP_CIRCLE_ROTATE
		Enums.Groups.STRAIGHT: group_tscn = NOTE_GROUP_STRAIGHT
	
	if group_tscn != null: return group_tscn
	else: print_debug("no grouping matching that name?!")
	
func _fetch_group_special(group_name : Enums.Groups):
	var group_tscn = null
	match group_name:
		Enums.GroupsSpecial.BIG_DIPPER: group_tscn = NOTE_GROUP_BIG_DIPPER
	
	if group_tscn != null: return group_tscn
	else: print_debug("no grouping matching that name?!")
	

func _end_song():
	Events.level_ended.emit()
	SceneManager.load_level_select_scene()
