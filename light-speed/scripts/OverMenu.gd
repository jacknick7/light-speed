extends MarginContainer


func update_score(score):
	$VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel.text = str(score) + " points"
	var file = File.new()
	var err = file.open("user://leaderboard.save", File.READ)
	if err == OK:
		var leaderboard = parse_json(file.get_line())
		var names = leaderboard["names"]
		var scores = leaderboard["scores"]
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
			names[i] = str(daytime["day"]) + '.' + str(daytime["month"]) + '.' + str(daytime["year"])
			file.close()
			err = file.open("user://leaderboard.save", File.WRITE)
			if err == OK:
				file.store_line(to_json({"names":names, "scores":scores}))
			else:
				print("Error " + err + " opening leaderboard for writing")
		file.close()
	else:
		print("Error " + err + " opening leaderboard for reading")
