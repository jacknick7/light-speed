extends MarginContainer


func update_score(score):
	$VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel.text = str(score) + " points"
