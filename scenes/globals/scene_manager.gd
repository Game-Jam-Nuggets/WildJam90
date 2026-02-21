extends Node

## --- public vars ---
var current_scene: Node = null

## --- export vars ---
@export var main_menu_scene: PackedScene
@export var game_scene: PackedScene
@export var settings_scene: PackedScene

## --- default methods ---

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_main_menu_scene()
	
## --- public methods ---

## Changes the room
func change_room(scene: PackedScene) -> void:
	# Remove current room
	if current_scene and is_instance_valid(current_scene):
		current_scene.queue_free()
		
	# Load new room
	current_scene = scene.instantiate()
	add_child(current_scene)

## Loads game scene
func load_game_scene():
	change_room(game_scene)

## Loads the main menu scene
func load_main_menu_scene():
	change_room(main_menu_scene)
	
## Loads settings scene
func load_settings_scene():
	change_room(settings_scene)
