extends MarginContainer


onready var name_labels = [
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel1,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel2,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel3,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel4,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/NameLabel5
]
onready var score_labels = [
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel1,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel2,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel3,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel4,
	$VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/VBoxContainer3/ScoreLabel5
]
onready var nameLE = $VBoxContainer/CenterContainer2/VBoxContainer2/LineEdit
onready var scoreLabel = $VBoxContainer/CenterContainer/VBoxContainer/ScoreLabel
onready var diffLabel = $VBoxContainer/CenterContainer2/VBoxContainer/DiffLabel
var leaderboard
var tmp_score
var tmp_diff
signal game_over_end()


func set_leaderboard(lb):
	leaderboard = lb


func handle_lb(score, diff):
	tmp_score = score
	tmp_diff = diff
	if leaderboard.is_record(score, diff): display_record()
	else: 
		display_lb(leaderboard.get_lb(diff))
		emit_signal("game_over_end")


func display_record():
	nameLE.text = ""
	$VBoxContainer/CenterContainer2/VBoxContainer.hide()
	$VBoxContainer/CenterContainer2/VBoxContainer2.show()


func display_score(score):
	scoreLabel.text = str(score) + " points" 


func display_difficulty(diff):
	diffLabel.text = diff + " difficulty"


func display_lb(lb):
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
	$VBoxContainer/CenterContainer2/VBoxContainer.show()
	$VBoxContainer/CenterContainer2/VBoxContainer2.hide()


func _on_EnterButton_pressed():
	var name = nameLE.text
	if name.length() < 1:
		nameLE.text = "Name cannot be empty"
		yield(get_tree().create_timer(1), "timeout")
		nameLE.text = ""
	elif name.length() > 8:
		nameLE.text = "Name at most 8 chars"
		yield(get_tree().create_timer(1), "timeout")
		nameLE.text = ""
	else:
		leaderboard.update_store_lb(tmp_score, name, tmp_diff)
		display_lb(leaderboard.get_lb(tmp_diff))
		$VBoxContainer/CenterContainer2/VBoxContainer.show()
		$VBoxContainer/CenterContainer2/VBoxContainer2.hide()
		emit_signal("game_over_end")

