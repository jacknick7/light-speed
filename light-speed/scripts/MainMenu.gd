extends MarginContainer


signal start()
signal instructions()
signal options()
signal credits()

func _on_StartButton_pressed():
	emit_signal("start")


func _on_InstructionsButton_pressed():
	emit_signal("instructions")


func _on_OptionsButton_pressed():
	emit_signal("options")


func _on_CreditsButton_pressed():
	emit_signal("credits")


func _on_ExitButton_pressed():
	get_tree().quit()
