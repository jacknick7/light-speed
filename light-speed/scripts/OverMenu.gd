extends MarginContainer


onready var name_labels = [
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel1,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel2,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel3,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel4,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel5,
]
onready var score_labels = [
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel1,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel2,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel3,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel4,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel5,
]
var new_score
signal displaying_leaderb


func game_over(score, lb):
	display_score(score)
	if lb == null:
		$VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit.text = ""
		$VBoxContainer/CenterContainer2/VBoxContainer.hide()
		$VBoxContainer/CenterContainer2/VBoxContainer2.show()
	else:
		display_leaderb(lb)
		$VBoxContainer/CenterContainer2/VBoxContainer.show()
		$VBoxContainer/CenterContainer2/VBoxContainer2.hide()


func display_score(score):
	$VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel.text = str(score) + " points"


func display_leaderb(lb):
	var ind = 0
	var names = lb["names"]
	var scores = lb["scores"]
	while ind < scores.size():
		if scores[ind] == null:
			name_labels[ind].text = "..."
			score_labels[ind].text = "..."
		else:
			name_labels[ind].text = names[ind]
			score_labels[ind].text = str(scores[ind])
		ind += 1


func _on_EnterButton_pressed():
	var name = $VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit.text
	if name.length() < 1:
		$VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit.text = "Name cannot be empty"
		yield(get_tree().create_timer(1), "timeout")
		$VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit.text = ""
	elif name.length() > 8:
		$VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit.text = "Name too long"
		yield(get_tree().create_timer(1), "timeout")
		$VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit.text = ""
	else:
		var new_name = $VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit.text
		#update_leaderb(new_name)
		$VBoxContainer/CenterContainer2/VBoxContainer.show()
		$VBoxContainer/CenterContainer2/VBoxContainer2.hide()
		emit_signal("displaying_leaderb")
