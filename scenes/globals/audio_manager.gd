extends Node

# --- export variables ---
@export var ui_click_sounds: Array[AudioStream]

# -- private variables ---
var playing: bool = false

# --- onready variables ---
@onready var music_player: AudioStreamPlayer = $MusicPlayer

# --- built-in functions ---
func _ready():
	pass

# --- public methods ---

## Updates the parameter for main music and plays
## @param stream: The audiostream to play
func set_music(stream: AudioStream, volume := 1.0, pitch := 1.0, position := 0.0):
	playing = true
	music_player.stream = stream
	music_player.volume_linear = volume
	music_player.pitch_scale = pitch
	music_player.play(position)
	
## Stops the main music
func stop_music():
	playing = false
	music_player.stop()
	
## Plays the given sound effect
## @param stream: The audiostream to play
## @param volume: The volume to play at
func play_sfx(stream: AudioStream, volume := 1.0, pitch := 1.0):
	var p = AudioStreamPlayer.new()
	p.bus = "SFX"
	p.stream = stream
	p.volume_linear = volume
	p.pitch_scale = pitch
	add_child(p)
	p.play()

	p.finished.connect(func(): p.queue_free())
	
## Plays ui click sound
func play_ui_click():
	play_sfx(ui_click_sounds.pick_random())
	
## Sets the music volume
## @param value: The new volume value
func set_music_volume(value: float):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)
	
## Returns the music volume
## @return: The volume
func get_music_volume() -> float:
	return AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Music"))

## Sets the sound volume
## @param value: The new volume value
func set_sfx_volume(value: float):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
	
## Returns the sound volume
## @return: The volume
func get_sound_volume() -> float:
	return AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("SFX"))
