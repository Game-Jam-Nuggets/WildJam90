extends Node2D

@export var footstep_sounds: Array[AudioStream]
@export var sword_slash_sounds: Array[AudioStream]

@onready var sword_animation_player: AnimationPlayer = $HylaBody/SwordAnimationPlayer

func _ready():
	Events.group_finished.connect(play_sword_swing)

func play_footstep():
	#AudioManager.play_sfx(footstep_sounds.pick_random(), 0.3, randf_range(0.9, 1.1))
	pass
	
func play_sword_swing(rating):
	if (rating != Enums.GroupRating.MISS):
		AudioManager.play_sfx(sword_slash_sounds.pick_random(), 0.5)
		sword_animation_player.play("sword_swing")
