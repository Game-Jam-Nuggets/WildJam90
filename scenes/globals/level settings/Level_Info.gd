extends Resource
class_name Level_Info

enum LEVEL_NAME { # set actual names later
	LEVEL_1,
	LEVEL_2,
	LEVEL_3
}

@export var name : LEVEL_NAME
@export var music_file : AudioStream
@export var bpm : int
@export var conductor_anim : String
@export_file_path("*.tscn", "*.scn") var background_tscn_path : String
