extends Node


signal start_game(easy)


func initialize(leaderboard, settings):
	$OverMenu.set_leaderboard(leaderboard)
	$OptionsMenu.initialize(settings)
	$MainMenu.show()
	$MainMenu.initialize()


func game_over(score, diff):
	$BlurColorRect.show()
	$OverMenu.display_score(score)
	$OverMenu.display_difficulty(diff)
	$OverMenu.handle_lb(score, diff)
	$OverMenu.show()


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


func _on_OverMenu_game_over_end():
	yield(get_tree().create_timer(3), "timeout")
	$OverMenu.hide()
	$MainMenu.show()
	$MainMenu.initialize()

