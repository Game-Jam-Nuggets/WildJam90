extends CanvasLayer

@onready var star_progress_bar: StarProgressBar = $VBoxContainer/StarProgressBar
@onready var points_label: Label = $VBoxContainer/Label
@onready var album_art: TextureRect = $AlbumArt
@onready var level_name: Label = $LevelName
@onready var back_button: Button = $BackButton


func _ready():
	back_button.pressed.connect(_on_back_button_pressed)
	Events.score_updated.connect(update_score)
	update_score(0, 0)
	album_art.texture = Gamestate.current_level_info.cover_art
	level_name.text = Gamestate.current_level_info.level_name


func update_score(p_new_score: int, p_new_score_max: int) -> void:
	var new_score_ratio := 0.0
	if p_new_score_max > 0:
		var music_progress = AudioManager.music_player.get_playback_position()/AudioManager.music_player.stream.get_length()
		new_score_ratio = lerpf(0.0, p_new_score / float(p_new_score_max), music_progress)
	star_progress_bar.progress = new_score_ratio
	points_label.text = str(p_new_score)

func _on_back_button_pressed() -> void:
	Events.level_ended.emit(false)
	SceneManager.load_level_select_scene()
