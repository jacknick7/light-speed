extends MarginContainer


onready var score_label = $VBoxContainer/ScoreLabel
onready var add_score_label = $VBoxContainer/AddScoreLabel
onready var sl_label = $VBoxContainer/SLLabel
onready var jump_tr = $VBoxContainer/JumpTR
onready var short_jump_tex = load("res://textures/jump/jump_0.png")
onready var long_jump_tex = load("res://textures/jump/jump_1.png")
const SL_TEXT = "Outside screen limits"


func initialize():
	score_label.hide()
	jump_tr.hide()


func game_over():
	add_score_label.text = ''
	sl_label.text = ''
	score_label.hide()
	jump_tr.hide()


func update_score(score, show_score):
	if show_score > 0:
		add_score_label.text = str(show_score)
		$Timer.start()
	score_label.text = str(score)


func display_screen_limits():
	sl_label.text = SL_TEXT
	$SLTimer.start()


func start_game():
	score_label.show()
	jump_tr.texture = long_jump_tex
	jump_tr.show()


func jump_change():
	if jump_tr.texture == long_jump_tex: jump_tr.texture = short_jump_tex
	else: jump_tr.texture = long_jump_tex


func _on_Timer_timeout():
	add_score_label.text = ''


func _on_SLTimer_timeout():
	sl_label.text = ''

