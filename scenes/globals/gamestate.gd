extends Node

@export var level_infos : Array[Level_Info]
var level_dict = {}

# shifts the song to start further in, nice for testing tracks
const debug_start_time = 0.0 # seconds

# song vars 
var current_bpm := 60 # default
var beat_length = 60.0 / float(current_bpm) # seconds
var note_existence_length = 4 # beats - need to move this to an export of group vars
var group_existence_length = 4 # beats

# storing counts of interactions
var note_count := 0
var note_hit_count := 0

var perfect_count := 0
var good_count := 0
var okay_count := 0
var miss_count := 0

# 1. instantiate variables for a choosen song / level ***
# 2. track scoring and progress of a song ***
# 3. calculate results for display at the end of a song 

func _ready():
	_establish_events()
	
	for info in level_infos:
		level_dict[info.name] = info

func _establish_events():
	Events.group_finished.connect(_group_finished)
	Events.note_hit.connect(_note_hit)
	Events.note_spawned.connect(_note_spawned)
	Events.level_selected.connect(_setup_level)

func _setup_level(level_name : Level_Info.LEVEL_NAME):
	if !level_dict.has(level_name): push_error("Unable to find " + str(level_name) + "in level info class!")
	else:
		var level_info : Level_Info = level_dict[level_name]
		# setup gamestate vars (more likely later)
		current_bpm = level_info.bpm
		beat_length = 60.0 / float(current_bpm)
		
		Events.level_start.emit(level_info) # sending this out from gamestate after setting vars to avoid a race condition

#### counting methods
func _note_hit(): note_hit_count += 1
func _note_spawned(): note_count += 1
func _group_finished(rating): # tracking group progress
	match rating:
		Enums.GroupRating.PERFECT : perfect_count += 1
		Enums.GroupRating.GOOD : good_count += 1
		Enums.GroupRating.OKAY : okay_count += 1
		Enums.GroupRating.MISS : perfect_count += 1
