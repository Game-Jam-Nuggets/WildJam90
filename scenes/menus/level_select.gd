extends Control

func _on_level_1_pressed() -> void:
	AudioManager.play_ui_click()
	SceneManager.load_game_scene()

func _on_level_2_pressed() -> void:
	AudioManager.play_ui_click()
	SceneManager.load_game_scene()

func _on_return_button_pressed() -> void:
	AudioManager.play_ui_click()
	SceneManager.load_main_menu_scene()
