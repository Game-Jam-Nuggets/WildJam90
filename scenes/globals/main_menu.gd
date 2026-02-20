extends Control

#3 --- export vars ---

@export var button_sound: AudioStream

## --- onready vars ---

@onready var levels_button: Button = $LevelsButton
@onready var settings_button: Button = $SettingsButton
@onready var credits_button: Button = $CreditsButton

## --- button methods ---

func _on_levels_button_pressed() -> void:
	AudioManager.play_sfx(button_sound)
	SceneManager.load_game_scene()
	pass

func _on_settings_button_pressed() -> void:
	AudioManager.play_sfx(button_sound)
	pass

func _on_credits_button_pressed() -> void:
	AudioManager.play_sfx(button_sound)
	pass
