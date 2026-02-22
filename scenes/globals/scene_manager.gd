extends Node

## --- public vars ---
var current_scene: Node = null

## --- export vars ---
@export var main_menu_scene: PackedScene
@export var intro_scene: PackedScene
@export var level_select_scene: PackedScene
@export var game_scene: PackedScene
@export var settings_scene: PackedScene
@export var credits_scene: PackedScene

## --- default methods ---

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var do_intro = func():
		if SaveManager.save_data.intro_played:
			load_main_menu_scene()
		else:
			load_intro_scene()
	do_intro.call_deferred()
	
## --- public methods ---

## Changes the room
func change_room(scene: PackedScene) -> void:
	# Remove current room
	if current_scene and is_instance_valid(current_scene):
		current_scene.queue_free()
		
	# Load new room
	current_scene = scene.instantiate()
	add_child(current_scene)

func load_intro_scene():
	AudioManager.stop_music()
	change_room(intro_scene)

## Loads game scene
func load_game_scene():
	change_room(game_scene)

## Loads the main menu scene
func load_main_menu_scene():
	change_room(main_menu_scene)
	
## Loads level select scene
func load_level_select_scene():
	change_room(level_select_scene)
	
## Loads settings scene
func load_settings_scene():
	change_room(settings_scene)
	
## Loads credits scene
func load_credits_scene():
	change_room(credits_scene)
