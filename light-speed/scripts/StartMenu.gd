extends MarginContainer


onready var note = $HBoxContainer/VBoxContainer/MenuOptions/NoteLabel

signal start_game(easy)
signal back()


func _on_EasyButton_pressed():
	emit_signal("start_game", true)


func _on_EasyButton_mouse_entered():
	note.text = "Easy dificulty: shows the next position of the ship at all times, recomended dificulty for starters."


func _on_EasyButton_mouse_exited():
	note.text = ""


func _on_NormalButton_pressed():
	emit_signal("start_game", false)


func _on_NormalButton_mouse_entered():
	note.text = "Normal dificulty: player must predict the next position of the ship, recomended to experienced players."


func _on_NormalButton_mouse_exited():
	note.text = ""


func _on_BackButton_pressed():
	emit_signal("back")
