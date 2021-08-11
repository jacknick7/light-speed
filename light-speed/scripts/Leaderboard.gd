"""
Handles the leaderboard
Loads, updates and stores the leaderboard
"""
# TODO: -look if there's a better way to store leaderboard without using jason
#       -add one leaderboard for each difficulty 
extends Node


var leaderboard = null


func create_lb():
	"""
	Creates a new leaderboard with values for names and scores set to null.
	"""
	var file = File.new()
	var err = file.open("user://leaderboard.save", File.WRITE)
	if err == OK:
		leaderboard = {
			"names" : [null, null, null, null, null],
			"scores" : [null, null, null, null, null]
		}
		file.store_line(to_json(leaderboard))
		file.close()
	else:
		print("Error " + err + " creating leaderboard file")


func load_lb():
	"""
	Loads the leaderboard from an existing file.
	"""
	var file = File.new()
	var err = file.open("user://leaderboard.save", File.READ)
	if err == OK:
		leaderboard = parse_json(file.get_line())
		file.close()
	else:
		print("Error " + err + " reading leaderboard file")


func is_record(new_score):
	"""
	Checks if new_score enters the leaderboard.
	If var leaderboard is null it also handles its creation or load.
	"""
	if leaderboard == null:
		var file = File.new()
		if file.file_exists("user://leaderboard.save"): load_lb()
		else: create_lb()
	var scores = leaderboard["scores"]
	if scores[scores.size() - 1] == null: return true
	if scores[scores.size() - 1] < new_score: return true
	return false


func update_lb(new_score, new_name):
	var i = 0
	var found = false
	var scores = leaderboard["scores"]
	var names = leaderboard["names"]
	while !found:
		if scores[i] == null: found = true
		elif scores[i] < new_score: found = true
		else: i += 1
	if scores[i] != null:
		var j = scores.size() - 1
		while j > i:
			names[j] = names[j-1]
			scores[j] = scores[j-1]
			j -= 1
	scores[i] = new_score
	names[i] = new_name
	leaderboard = {"names": names, "scores": scores}
