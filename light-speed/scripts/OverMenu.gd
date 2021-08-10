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
var names
var scores
var new_score
signal displaying_leaderb


func game_over(score):
	display_score(score)
	var record = load_check_leaderb(score)
	if record:
		$VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit.text = ""
		$VBoxContainer/CenterContainer2/VBoxContainer.hide()
		$VBoxContainer/CenterContainer2/VBoxContainer2.show()
	else:
		display_leaderb()
		$VBoxContainer/CenterContainer2/VBoxContainer.show()
		$VBoxContainer/CenterContainer2/VBoxContainer2.hide()
	return record


func display_score(score):
	$VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel.text = str(score) + " points"


func load_check_leaderb(score):
	var file = File.new()
	var err = file.open("user://leaderboard.save", File.READ)
	if err == OK:
		var leaderboard = parse_json(file.get_line())
		file.close()
		names = leaderboard["names"]
		scores = leaderboard["scores"]
		if scores[scores.size() - 1] == null || scores[scores.size() - 1] < score:
			new_score = score
			return true
	else:
		print("Error " + err + " opening leaderboard for reading")
	return false


func update_leaderb(new_name):
	var i = 0
	var found = 0
	while i < scores.size() && found == 0:
		if scores[i] == null:
			found = 1
		elif scores[i] < new_score:
			found = 2
		else:
			i += 1
	if found != 0:
		if found == 2:
			var j = scores.size() - 1
			while j > i:
				names[j] = names[j-1]
				scores[j] = scores[j-1]
				j -= 1
		scores[i] = new_score
		names[i] = new_name
	store_leaderb()
	display_leaderb()



func store_leaderb():
	var file = File.new()
	var err = file.open("user://leaderboard.save", File.WRITE)
	if err == OK:
		file.store_line(to_json({"names":names, "scores":scores}))
	else:
		print("Error " + err + " opening leaderboard for writing")
	file.close()


func display_leaderb():
	var ind = 0
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
		update_leaderb(new_name)
		$VBoxContainer/CenterContainer2/VBoxContainer.show()
		$VBoxContainer/CenterContainer2/VBoxContainer2.hide()
		emit_signal("displaying_leaderb")
