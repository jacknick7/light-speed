extends CanvasLayer


func _ready():
	$ScoreLabel.hide()
	$MessageLabel.hide()


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$ScoreLabel.hide()


func update_score(score, show_score):
	if show_score > 0:
		$ScoreLabel.text = str(score) + "\n+" + str(show_score)
	else:
		$ScoreLabel.text = str(score)


func start_game():
	$ScoreLabel.show()


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
