extends MarginContainer


onready var note = $HBoxContainer/VBoxContainer/MenuOptions/NoteLabel

signal start_game(easy)
signal back()


func _on_EasyButton_pressed():
	note.text = "\n"
	emit_signal("start_game", true)


func _on_EasyButton_mouse_entered():
	note.text = "Shows the next position of the ship at all times, recommended difficulty for beginners."


func _on_EasyButton_mouse_exited():
	note.text = "\n"


func _on_NormalButton_pressed():
	note.text = "\n"
	emit_signal("start_game", false)


func _on_NormalButton_mouse_entered():
	note.text = "Player must predict the next position of the ship, recommended for experienced players."


func _on_NormalButton_mouse_exited():
	note.text = "\n"


func _on_BackButton_pressed():
	emit_signal("back")
