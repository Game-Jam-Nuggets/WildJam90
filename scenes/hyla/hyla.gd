extends Node2D

@export var footstep_sounds: Array[AudioStream]

func play_footstep():
	AudioManager.play_sfx(footstep_sounds.pick_random(), 0.3, randf_range(0.9, 1.1))
