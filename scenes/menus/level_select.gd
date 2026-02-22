extends Control

@export var level_select_sound: AudioStream
@export var main_theme: AudioStream
@onready var hi_score_level_1: Label = $HBoxContainer/MarginContainer/GridContainer/VBoxContainer2/HiScoreLevel1
@onready var hi_score_level_2: Label = $HBoxContainer/MarginContainer/GridContainer/VBoxContainer/HiScoreLevel2

func _ready() -> void:
	AudioManager.set_music(main_theme)
	hi_score_level_1.text = str(SaveManager.get_score(Level_Info.LEVEL_ID.LEVEL_1))
	hi_score_level_2.text = str(SaveManager.get_score(Level_Info.LEVEL_ID.LEVEL_2))

func _on_level_1_pressed() -> void:
	AudioManager.play_sfx(level_select_sound)
	Events.level_selected.emit(Level_Info.LEVEL_ID.LEVEL_1)

func _on_level_2_pressed() -> void:
	AudioManager.play_sfx(level_select_sound)
	Events.level_selected.emit(Level_Info.LEVEL_ID.LEVEL_2)

func _on_return_button_pressed() -> void:
	AudioManager.play_ui_click()
	SceneManager.load_main_menu_scene()
