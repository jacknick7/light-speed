extends MarginContainer


func update_score(score):
	$VBoxContainer/ScoreLabel.text = str(score) + " points"
