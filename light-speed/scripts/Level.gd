extends Node


var ini_position
var score
var volume
var skip_intro
var easy


func _ready():
	randomize()
	$Settings.initialize()
	$Background.initialize()
	ini_position = $HexagonMatrix.initialize()
	$Player.initialize()
	$Menu.initialize($Leaderboard, $Settings)
	$HUD.initialize()
	#print(str(ini_position))


func set_skip_intro(new_skip_intro):
	skip_intro = new_skip_intro


# TODO: make the intro
func start_game(is_easy):
	#print(easy)
	easy = is_easy
	if !skip_intro:
		print("Show intro here")
	$HUD.start_game()
	$HexagonMatrix.start_game(self)
	$UpdateTimer.start()
	$ScoreTimer.start()
	score = 0
	$HUD.update_score(score, 0)
	$Player.start_game(is_easy, ini_position)


func game_over():
	$Player.game_over()
	$UpdateTimer.stop()
	$ScoreTimer.stop()
	$HUD.game_over()
	$HexagonMatrix.game_over(self)
	var diff = "Normal"
	if easy: diff = "Easy"
	$Menu.game_over(score, diff)


func _on_UpdateTimer_timeout():
	$HexagonMatrix.update_matrix()
	#$Player.trigger_hexagon()


func _on_ScoreTimer_timeout():
	score += 10
	$HUD.update_score(score, 0)

# TODO: look how to handle _on_Hexagon_damaged & _on_Hexagon_scored so it's only
# active between start_game & game_over
func _on_Hexagon_damaged():
	#print("Damaged")
	game_over()


func _on_Hexagon_scored(add_score):
	print("Scored: " + str(add_score))
	score += add_score
	$HUD.update_score(score, add_score)

