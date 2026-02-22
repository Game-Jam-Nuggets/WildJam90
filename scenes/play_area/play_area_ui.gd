extends CanvasLayer

@onready var star_progress_bar: StarProgressBar = $VBoxContainer/StarProgressBar
@onready var points_label: Label = $VBoxContainer/Label

func _ready():
	Events.score_updated.connect(update_score)
	update_score(0, 0)


func update_score(p_new_score: int, p_new_score_max: int) -> void:
	var new_score_ratio := 0.0
	if p_new_score_max > 0:
		new_score_ratio = p_new_score / float(p_new_score_max)
	star_progress_bar.progress = new_score_ratio
	points_label.text = str(p_new_score)
