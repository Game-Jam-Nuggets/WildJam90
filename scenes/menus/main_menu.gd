extends Control

#3 --- export vars ---

@export var button_sound: AudioStream
@export var title_theme: AudioStream

## --- onready vars ---

@onready var levels_button: Button = $LevelsButton
@onready var settings_button: Button = $SettingsButton
@onready var credits_button: Button = $CreditsButton

func _ready():
	AudioManager.set_music(title_theme)

## --- button methods ---

func _on_levels_button_pressed() -> void:
	AudioManager.play_sfx(button_sound)
	SceneManager.load_level_select_scene()

func _on_settings_button_pressed() -> void:
	AudioManager.play_sfx(button_sound)
	SceneManager.load_settings_scene()

func _on_credits_button_pressed() -> void:
	AudioManager.play_sfx(button_sound)
	SceneManager.load_credits_scene()

func _on_intro_button_pressed() -> void:
	AudioManager.play_sfx(button_sound)
	SceneManager.load_intro_scene()
