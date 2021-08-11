extends Node


signal start_game(easy)
signal change_resolution(new_res)
signal change_volume(new_vol)
signal skip_intro(new_skip)


func initialize():
	$OptionsMenu.initialize()
	$MainMenu.show()
	$MainMenu.initialize()


func game_over(score, lb = null):
	$BlurColorRect.show()
	$OverMenu.game_over(score, lb)
	$OverMenu.show()
	if lb != null:
		displaying_leaderb()


func _on_MainMenu_start():
	$MainMenu.hide()
	$StartMenu.show()


func _on_MainMenu_instructions():
	$MainMenu.hide()
	$InstructionsMenu.show()


func _on_MainMenu_options():
	$MainMenu.hide()
	$OptionsMenu.show()


func _on_MainMenu_credits():
	$MainMenu.hide()
	$CreditsMenu.show()


func _on_StartMenu_start_game(easy):
	$StartMenu.hide()
	$BlurColorRect.hide()
	emit_signal("start_game", easy)


func _on_StartMenu_back():
	$StartMenu.hide()
	$MainMenu.show()


func _on_InstructionsMenu_back():
	$InstructionsMenu.hide()
	$MainMenu.show()


func _on_CreditsMenu_back():
	$CreditsMenu.hide()
	$MainMenu.show()


func _on_OptionsMenu_back():
	$OptionsMenu.hide()
	$MainMenu.show()


func _on_OptionsMenu_change_resolution(new_res):
	emit_signal("change_resolution", new_res)


func _on_OptionsMenu_change_volume(new_vol):
	emit_signal("change_volume", new_vol)


func _on_OptionsMenu_skip_intro(new_skip):
	emit_signal("skip_intro", new_skip)


func displaying_leaderb():
	yield(get_tree().create_timer(3), "timeout")
	$OverMenu.hide()
	initialize()
