extends CanvasLayer

@onready var rating_label: Label = $Control/MarginContainer/rating_label
@onready var rating_animator: AnimationPlayer = $rating_animator
@onready var star_progress_bar: StarProgressBar = $VBoxContainer/StarProgressBar
@onready var points_label: Label = $VBoxContainer/Label


func _ready():
	Events.group_finished.connect(update_rating)
	Events.score_updated.connect(update_score)
	update_score(0, 0)

func update_rating(rating : Enums.GroupRating):
	rating_animator.play("RESET") 
	
	var rating_text : String
	match rating:
		Enums.GroupRating.MISS : rating_text = "miss!"
		Enums.GroupRating.OKAY : rating_text = "okay!"
		Enums.GroupRating.GOOD : rating_text = "good!"
		Enums.GroupRating.PERFECT : rating_text = "perfect!"
	
	rating_label.text = rating_text
	rating_animator.play("update_rating")

func update_score(p_new_score: int, p_new_score_max: int) -> void:
	var new_score_ratio := 0.0
	if p_new_score_max > 0:
		new_score_ratio = p_new_score / float(p_new_score_max)
	star_progress_bar.progress = new_score_ratio
	points_label.text = str(p_new_score)
