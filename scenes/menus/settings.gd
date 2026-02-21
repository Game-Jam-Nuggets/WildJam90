extends Control

# --- onready variables ---
@onready var volume_slider: HSlider = $VolumeSlider
@onready var music_volume_slider: HSlider = $MusicVolumeSlider
@onready var sound_volume_slider: HSlider = $SoundVolumeSlider

func _ready() -> void:
	volume_slider.value = AudioServer.get_bus_volume_linear(0)
	music_volume_slider.value = AudioManager.get_music_volume()
	sound_volume_slider.value = AudioManager.get_sound_volume()

## --- listener methods ---

func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioManager.set_music_volume(value)

func _on_sound_volume_slider_value_changed(value: float) -> void:
	AudioManager.play_ui_click()
	AudioManager.set_sfx_volume(value)

func _on_return_button_pressed() -> void:
	AudioManager.play_ui_click()
	SceneManager.load_main_menu_scene()
