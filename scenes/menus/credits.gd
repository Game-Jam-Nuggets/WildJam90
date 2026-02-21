extends Control



func _on_return_button_pressed() -> void:
	AudioManager.play_ui_click()
	SceneManager.load_main_menu_scene()
