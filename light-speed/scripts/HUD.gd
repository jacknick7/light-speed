extends MarginContainer


onready var score_label = $VBoxContainer/ScoreLabel


func initialize():
	score_label.hide()


func game_over():
	score_label.hide()


func update_score(score, show_score):
	if show_score > 0:
		score_label.text = str(score) + "\n+" + str(show_score)
	else:
		score_label.text = str(score)


func start_game():
	score_label.show()
