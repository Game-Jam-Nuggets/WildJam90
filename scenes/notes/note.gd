extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var existence_timer: Timer = $existence_timer
@onready var particle_emitter_hit: GPUParticles2D = $particle_emitter_hit

@export var note_existence_length = 4 # beats
@export var bonus_note: bool = false # whether to count this note as a bonus or not

@export_subgroup("technicals")
@export var star_break_sounds: Array[AudioStream]

signal hit
signal miss

var note_hit = false # used to track so theres no double signal call from miss collider
var enable_miss_hitbox = false # for testing, this might be annoying as fuck?

func _ready():
	animation_player.speed_scale = Gamestate.current_bpm / 60
	animation_player.play("spawning")
	
	if bonus_note: Events.bonus_note_spawned.emit()
	else: Events.note_spawned.emit()
	
	if bonus_note: # for now, modulate color
		self.modulate = Color.MAGENTA
	
	global_rotation = 0.0 # ensure stars are always upright

func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	existence_timer.stop()
	
	note_hit = true
	animation_player.speed_scale = 1.0
	animation_player.play("hit")
	
	AudioManager.play_sfx(star_break_sounds.pick_random(), 0.5)
	
	hit.emit()
	Events.note_hit.emit()
	
	# spawn emitter
	self.remove_child(particle_emitter_hit)
	add_sibling(particle_emitter_hit)
	particle_emitter_hit.global_position = self.global_position
	
	particle_emitter_hit.emitting = true

func start_existence():
	existence_timer.wait_time = Gamestate.beat_length * note_existence_length
	existence_timer.start()

func note_missed():
	animation_player.speed_scale = 1.0
	animation_player.play("miss")
	
	miss.emit()

func _on_area_miss_collider_mouse_shape_exited(shape_idx: int) -> void:
	if !note_hit && enable_miss_hitbox: # if the inner collider wasn't touched upon outer exit
		note_missed()

func _on_existence_timer_timeout() -> void:
	note_missed()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"spawning": start_existence()
		"hit": queue_free()
		"miss": queue_free()


func _on_particle_emitter_hit_finished() -> void:
	pass # Replace with function body.
