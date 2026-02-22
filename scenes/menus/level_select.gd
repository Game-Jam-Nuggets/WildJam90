extends Control

@export var level_select_sound: AudioStream

func _on_level_1_pressed() -> void:
	AudioManager.play_sfx(level_select_sound)
	Events.level_selected.emit(Level_Info.LEVEL_ID.LEVEL_1)

func _on_level_2_pressed() -> void:
	AudioManager.play_sfx(level_select_sound)
	Events.level_selected.emit(Level_Info.LEVEL_ID.LEVEL_2)

func _on_return_button_pressed() -> void:
	AudioManager.play_ui_click()
	SceneManager.load_main_menu_scene()
