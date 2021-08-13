"""
Handles the leaderboard
Loads, updates and stores the leaderboard
"""
extends Node


const SAVE_PATH = "user://leaderboard.save"
const SAVE_PASS = "voidmystery"
var leaderboard = null


func create_lb():
	"""
	Creates a new leaderboard with values for names and scores set to null.
	"""
	var file = File.new()
	var err = file.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SAVE_PASS)
	if err == OK:
		leaderboard = {
			"Easy": {
				"names" : [null, null, null, null, null],
				"scores" : [null, null, null, null, null]
			},
			"Normal": {
				"names" : [null, null, null, null, null],
				"scores" : [null, null, null, null, null]
			}
		}
		file.store_line(to_json(leaderboard))
		file.close()
	else: print("Error " + err + " creating leaderboard file")


func load_lb():
	"""
	Loads the leaderboard from an existing file.
	"""
	var file = File.new()
	var err = file.open_encrypted_with_pass(SAVE_PATH, File.READ, SAVE_PASS)
	if err == OK:
		leaderboard = parse_json(file.get_line())
		file.close()
	else: print("Error " + err + " reading leaderboard file")


func is_record(new_score, new_diff):
	"""
	Checks if new_score enters the leaderboard.
	If var leaderboard is null it also handles its creation or load.
	"""
	if leaderboard == null:
		var file = File.new()
		if file.file_exists(SAVE_PATH): load_lb()
		else: create_lb()
	var scores = (leaderboard[new_diff])["scores"]
	if scores[scores.size() - 1] == null: return true
	if scores[scores.size() - 1] < new_score: return true
	return false


func update_lb(new_score, new_name, new_diff):
	"""
	Updates leaderboard by adding a new entry with new_score and new_name.
	It also reareng some positions if necessary.
	"""
	var i = 0
	var found = false
	var scores = (leaderboard[new_diff])["scores"]
	var names = (leaderboard[new_diff])["names"]
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
	leaderboard[new_diff] = {"names": names, "scores": scores}


func store_lb():
	"""
	Saves the leaderboard to a file.
	"""
	var file = File.new()
	var err = file.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SAVE_PASS)
	if err == OK: file.store_line(to_json(leaderboard))
	else: print("Error " + err + " writing leaderboard file")
	file.close()


func update_store_lb(new_score, new_name, new_diff):
	"""
	Updates and stores the leaderboard.
	"""
	update_lb(new_score, new_name, new_diff)
	store_lb()


func get_lb(new_diff):
	"""
	Get the leaderboard.
	"""
	return leaderboard[new_diff]

