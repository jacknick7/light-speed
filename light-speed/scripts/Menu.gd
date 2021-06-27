extends Node


signal start_game(easy)


func _on_MainMenu_start():
	$MainMenu.hide()
	$StartMenu.show()


func _on_MainMenu_instructions():
	$MainMenu.hide()
	$InstructionsMenu.show()


func _on_MainMenu_options():
	pass # Replace with function body.


func _on_MainMenu_credits():
	$MainMenu.hide()
	$CreditsMenu.show()


func _on_StartMenu_start_game(easy):
	$StartMenu.hide()
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
