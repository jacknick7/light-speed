extends Node


signal start_game(easy)
signal name_record(new_name)


func initialize(settings = null):
	if settings != null: $OptionsMenu.initialize(settings)
	$MainMenu.show()
	$MainMenu.initialize()


func game_over_init(score, diff):
	$BlurColorRect.show()
	$OverMenu.display_score(score)
	$OverMenu.display_difficulty(diff)
	$OverMenu.show()


func game_over_lb(lb):
	$OverMenu.display_lb(lb)
	yield(get_tree().create_timer(3), "timeout")
	$OverMenu.hide()
	initialize()


func game_over_record():
	$OverMenu.display_record()


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


func _on_OverMenu_name_record(new_name):
	emit_signal("name_record", new_name)

