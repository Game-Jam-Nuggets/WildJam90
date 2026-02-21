extends Control

var current_song_time
var can_fade_out_particles: bool
var can_fade_out_color_mask: bool

var subtitle_nodes: Array = []
var subtitle_text: Array = []

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($particles, "modulate:a", 1, 5)
	subtitle_nodes = $Subtitles.get_children()
	for subtitles in subtitle_nodes:
		subtitle_text += subtitles.get_children()
		

func _on_music_timeout() -> void:
	var tween = create_tween()
	$Story_music.play()
	
	tween.tween_property($particles, "speed_scale", 2.0, 2)
	tween.tween_property($particles, "lifetime", 2000, 300)
	
	tween.tween_callback($particles.queue_free)

func _process(delta: float) -> void:
	current_song_time = round($Story_music.get_playback_position())
	$Label_current_song_time.text = "" + str(current_song_time)
	if(current_song_time == 4):
		can_fade_out_color_mask = true
		can_fade_out_particles = true
	
	if(current_song_time == 9):
		var tween = create_tween()
		tween.tween_property($Story1, "modulate:a", 1, 1)
		tween.tween_property(subtitle_text[0], "modulate:a", 1, 1)
		
		$star.emitting = false
		# "HumanKind"

	if(current_song_time == 11):
		var tween = create_tween()
		tween.tween_property(subtitle_text[1], "modulate:a", 1, 1)
		# "A species"
		
	if(current_song_time == 14):
		var tween = create_tween()
		tween.tween_property(subtitle_text[2], "modulate:a", 1, 1)
		# "Has succumb"
		
	if(current_song_time == 17):
		var tween = create_tween()
		
		# Fade out paragraph 1
		tween.tween_property(subtitle_nodes[0], "modulate:a", 0, 0.2)
		
		# "A new order"
		tween.tween_property(subtitle_text[3], "modulate:a", 1, 0.2)
	
	if(current_song_time == 19):
		var tween = create_tween()
		tween.tween_property($Story2, "modulate:a", 1, 1)
		tween.tween_property(subtitle_text[4], "modulate:a", 1, 1)
		# "more evolved"
	
	if(current_song_time == 21):
		var tween = create_tween()
		tween.tween_property(subtitle_text[5], "modulate:a", 1, 1)
		# "more intelligent"
		
	if(current_song_time == 22):
		var tween = create_tween()
		tween.tween_property(subtitle_text[6], "modulate:a", 1, 1)
		# "more sentient"
	
	if(current_song_time == 24):
		var tween = create_tween()
		tween.tween_property(subtitle_text[7], "modulate:a", 1, 1)
		# "The Anura"
	
	if(current_song_time == 25):
		var tween = create_tween()
		# Fade out paragraph 2
		tween.tween_property(subtitle_nodes[1], "modulate:a", 0, 0.2)
		
		# "Cosmic amphibian power"
		tween.tween_property(subtitle_text[8], "modulate:a", 1, 1)
		
	if(current_song_time == 26):
		var tween = create_tween()
		
		tween.tween_property($Story3, "modulate:a", 1, 1)
		# "Cosmic amphibian power"
		tween.tween_property(subtitle_text[8], "modulate:a", 1, 0.2)
		
	if(current_song_time == 28):
		var tween = create_tween()
		
		# "Commanding"
		tween.tween_property(subtitle_text[9], "modulate:a", 1, 1)
		
	if(current_song_time == 29):
		var tween = create_tween()
		
		# "and around"
		tween.tween_property(subtitle_text[10], "modulate:a", 1, 1)
	
	if(current_song_time == 32):
		var tween = create_tween()
		
		# "with a force"
		tween.tween_property(subtitle_text[11], "modulate:a", 1, 1)
	
	if(current_song_time == 35):
		var tween = create_tween()
		# Fade out paragraph 3
		tween.tween_property(subtitle_nodes[2], "modulate:a", 0, 0.2)
		
		# "The Order"
		tween.tween_property(subtitle_text[12], "modulate:a", 1, 0.2)
		
	if(current_song_time == 36):
		var tween = create_tween()
		tween.tween_property($Story4, "modulate:a", 1, 1)
	
	if(current_song_time == 39):
		# "Unwavering"
		var tween = create_tween()
		tween.tween_property(subtitle_text[13], "modulate:a", 1, 1)
		
	if(current_song_time == 40):
		# "Uncompromising"
		var tween = create_tween()
		tween.tween_property(subtitle_text[14], "modulate:a", 1, 1)
		
		
		
	if(current_song_time == 43):
		var tween = create_tween()
		# "All but one"
		tween.tween_property(subtitle_text[15], "modulate:a", 1, 1)
		
		tween.tween_property($Story5, "modulate:a", 1, 1)

	
	if(current_song_time == 44):
		var tween = create_tween()
		
		# Fade out paragraph 4
		tween.tween_property(subtitle_nodes[3], "modulate:a", 0, 0.2)
		tween.tween_property(subtitle_text[16], "modulate:a", 1, 0.2)
	
	if(current_song_time == 45):
		var tween = create_tween()
		
		# "A brilliant"
		tween.tween_property(subtitle_text[17], "modulate:a", 1, 1)
	
	if(current_song_time == 48):
		var tween = create_tween()
		
		# "Rejected"
		tween.tween_property(subtitle_text[18], "modulate:a", 1, 1)
		
	if(current_song_time == 52):
		var tween = create_tween()
		
		# Fade out paragraph 5
		tween.tween_property(subtitle_nodes[4], "modulate:a", 0, 0.2)
		
		# "Fascinated"
		tween.tween_property(subtitle_text[19], "modulate:a", 1, 0.2)
		
	if(current_song_time == 54):
		var tween = create_tween()
		
		# "harmonious"
		tween.tween_property(subtitle_text[20], "modulate:a", 1, 1)
		
	if(current_song_time == 56):
		var tween = create_tween()
		
		# "music"
		tween.tween_property(subtitle_text[21], "modulate:a", 1, 1)
		tween.parallel()
		tween.tween_property($Story6,"modulate:a", 1, 1)
		
	if(current_song_time == 58):
		var tween = create_tween()
		
		# Fade out paragraph 6
		tween.tween_property(subtitle_nodes[5], "modulate:a", 0, 0.2)
		
		#"Without the order"
		tween.tween_property(subtitle_text[22], "modulate:a", 1, 0.2)
		
	if(current_song_time == 60):
		var tween = create_tween()
		
		#"But nothing"
		tween.tween_property(subtitle_text[23], "modulate:a", 1, 1)
		tween.tween_property($Story7, "modulate:a", 1, 1)
		
	if(current_song_time == 66):
		var tween = create_tween()
		
		#"One beat"
		tween.tween_property(subtitle_text[24], "modulate:a", 1, 1)
	
	if(current_song_time == 69):
		var tween = create_tween()
		
		# Fade out paragraph 7 (Last paragraph)
		tween.tween_property(subtitle_nodes[6], "modulate:a", 0, 1.5)
		
		# Load next scene
		
	if(can_fade_out_color_mask):
		var tween1 = create_tween()
		var tween2 = create_tween()
		tween1.tween_property($particles, "modulate:a", 0, 1 )
		tween2.tween_property($color_mask, "modulate:a", 0, 3 )
		
		$particles.emitting = false
		can_fade_out_particles = false
		can_fade_out_color_mask = false
