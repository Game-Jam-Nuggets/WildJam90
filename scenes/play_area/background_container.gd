extends Node2D

func _ready():
	Events.level_start.connect(_add_background)
	
func _add_background(level_info):
	for node in self.get_children(): node.queue_free() # clear any previous 
	
	var background = load(level_info.background_tscn_path)
	var new_background = background.instantiate()
	add_child(new_background)
		
