extends Node

const SAVE_PATH = "user://save.json"

var save_data: SaveData

func _ready() -> void:
	load_game()
	Events.level_ended.connect(_on_level_ended)

func load_game() -> void:
	save_data = SaveData.new()
	var save_game_dict: Variant = _read_save_file()
	if save_game_dict != null:
		save_data.read_dict(save_game_dict)

func save_game() -> void:
	var dict := save_data.to_dict()
	var json_string := JSON.stringify(dict)
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f:
		f.store_string(json_string)
		f.close()
	else:
		print("Failed to open save file for writing: %d " % FileAccess.get_open_error())

func _read_save_file() -> Variant:
	if FileAccess.file_exists(SAVE_PATH):
		var save_file_contents := FileAccess.get_file_as_string(SAVE_PATH)
		return JSON.parse_string(save_file_contents)
	return null

func _on_level_ended() -> void:
	if save_data.scores == null:
		save_data.scores = {}
	
	var level_id = Gamestate.current_level_info.level_id
	save_data.scores[level_id] = Gamestate.note_hit_count
	save_game()
