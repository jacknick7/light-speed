extends MarginContainer


onready var score_label = $VBoxContainer/ScoreLabel
onready var add_score_label = $VBoxContainer/AddScoreLabel
onready var sl_label = $VBoxContainer/SLLabel
const SL_TEXT = "Outside screen limits"


func initialize():
	score_label.hide()


func game_over():
	add_score_label.text = ''
	sl_label.text = ''
	score_label.hide()


func update_score(score, show_score):
	if show_score > 0:
		add_score_label.text = str(show_score)
		$Timer.start()
	score_label.text = str(score)


func display_screen_limits():
	sl_label.text = SL_TEXT
	$SLTimer.start()


func start_game():
	score_label.show()


func _on_Timer_timeout():
	add_score_label.text = ''


func _on_SLTimer_timeout():
	sl_label.text = ''

