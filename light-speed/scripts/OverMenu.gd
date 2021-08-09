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


func update_score(score):
	$VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel.text = str(score) + " points"


func update_leaderb(score):
	var names
	var scores
	var file = File.new()
	var err = file.open("user://leaderboard.save", File.READ)
	if err == OK:
		var leaderboard = parse_json(file.get_line())
		file.close()
		names = leaderboard["names"]
		scores = leaderboard["scores"]
		var i = 0
		var found = 0
		while i < scores.size() && found == 0:
			if scores[i] == null:
				found = 1
			elif scores[i] < score:
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
			scores[i] = score
			var daytime = OS.get_datetime()
			names[i] = str(daytime["day"]) + '.' + str(daytime["month"]) + '.' + str(daytime["year"]) + '.' +str(daytime["hour"]) + '.' + str(daytime["minute"]) + '.' + str(daytime["second"])
			err = file.open("user://leaderboard.save", File.WRITE)
			if err == OK:
				file.store_line(to_json({"names":names, "scores":scores}))
			else:
				print("Error " + err + " opening leaderboard for writing")
		file.close()
	else:
		print("Error " + err + " opening leaderboard for reading")
	var ind = 0
	while ind < scores.size():
		if scores[ind] == null:
			name_labels[ind].text = "..."
			score_labels[ind].text = "..."
		else:
			name_labels[ind].text = names[ind]
			score_labels[ind].text = str(scores[ind])
		ind += 1
