extends MarginContainer


signal start()
signal instructions()
signal options()
signal credits()

func _ready():
	initialize()


func initialize():
	$HBoxContainer/VBoxContainer/TitleLabel.visible = false
	$HBoxContainer/VBoxContainer/MenuOptions.visible = false
	$HBoxContainer/VBoxContainer/VersionLabel.visible = false
	$HBoxContainer/VBoxContainer/MadeLabel.visible = false
	$HBoxContainer/VBoxContainer2/ExitButton.visible = false
	yield(get_tree().create_timer(1), "timeout")
	$HBoxContainer/VBoxContainer/TitleLabel.visible = true
	yield(get_tree().create_timer(1.5), "timeout")
	$HBoxContainer/VBoxContainer/MenuOptions.visible = true
	$HBoxContainer/VBoxContainer/VersionLabel.visible = true
	$HBoxContainer/VBoxContainer/MadeLabel.visible = true
	yield(get_tree().create_timer(1), "timeout")
	$HBoxContainer/VBoxContainer2/ExitButton.visible = true


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
