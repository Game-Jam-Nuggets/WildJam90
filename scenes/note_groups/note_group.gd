extends Node2D

@onready var note_container: Node2D = $note_container
@onready var existence_timer: Timer = $existence_timer

@export var group_existence_length: int = 4 # beats

var note_count = 0
var notes_hit = 0
var notes_finished = 0

func _ready():
	for note in note_container.get_children():
		note_count += 1
		note.hit.connect(note_hit)
		note.miss.connect(note_missed)
		
	existence_timer.wait_time = Gamestate.beat_length * float(group_existence_length)
	await get_tree().create_timer(Gamestate.beat_length).timeout
	existence_timer.start()
	
func note_hit():
	notes_hit += 1
	notes_finished += 1
	if notes_finished == note_count:
		group_success()

func note_missed():
	notes_finished += 1
	if notes_finished == note_count:
		group_failed()


func group_success():
	var rating = null
	var group_length = Gamestate.beat_length * group_existence_length
	
	# calculate rating
	if existence_timer.time_left > group_length * 0.8: rating = Enums.GroupRating.PERFECT
	elif existence_timer.time_left > group_length * 0.6: rating = Enums.GroupRating.GOOD
	else: rating = Enums.GroupRating.OKAY

	Events.group_finished.emit(rating)
	
	await get_tree().create_timer(2.0).timeout
	queue_free()
	
func group_failed():
	Events.group_finished.emit(Enums.GroupRating.MISS)
	await get_tree().create_timer(2.0).timeout
	queue_free()
