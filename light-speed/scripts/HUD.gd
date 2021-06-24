extends CanvasLayer


signal start_game(easy)


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
	$TitleLabel.show()
	yield(get_tree().create_timer(1), "timeout")
	$VBoxContainer.show()


func update_score(score, show_score):
	if show_score > 0:
		$ScoreLabel.text = str(score) + "\n+" + str(show_score)
	else:
		$ScoreLabel.text = str(score)


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_StartButton_pressed():
	$VBoxContainer.hide()
	$TitleLabel.hide()
	$ScoreLabel.show()
	emit_signal("start_game", false)


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
