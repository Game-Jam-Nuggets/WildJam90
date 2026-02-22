extends Resource
class_name Level_Info

enum LEVEL_ID { # set actual names later
	LEVEL_1,
	LEVEL_2,
	LEVEL_3
}

@export var level_id : LEVEL_ID
@export var level_name : String
@export var music_file : AudioStream
@export var bpm : int
@export var conductor_anim : String
@export var cover_art: Texture2D
@export_file_path("*.tscn", "*.scn") var background_tscn_path : String
