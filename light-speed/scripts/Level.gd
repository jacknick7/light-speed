extends Node


var ini_position
var score


func _ready():
	randomize()
	ini_position = $HexagonMatrix.initialize()
	$Menu.initialize()
	#print(str(ini_position))


func start_game(easy):
	#print(easy)
	$HUD.start_game()
	$HexagonMatrix.start_game(self)
	$UpdateTimer.start()
	$ScoreTimer.start()
	score = 0
	$HUD.update_score(score, 0)
	$Player.start_game(easy, ini_position)


func game_over():
	$Player.game_over()
	$UpdateTimer.stop()
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$HexagonMatrix.game_over(self)
	yield(get_tree().create_timer(3), "timeout")
	$Menu.initialize()


func _on_UpdateTimer_timeout():
	$HexagonMatrix.update_matrix()
	$Player.trigger_hexagon()


func _on_ScoreTimer_timeout():
	score += 10
	$HUD.update_score(score, 0)

# TODO: look how to handle _on_Hexagon_damaged & _on_Hexagon_scored so it's only
# active between start_game & game_over
func _on_Hexagon_damaged():
	#print("Damaged")
	game_over()


func _on_Hexagon_scored(add_score):
	#print("Scored: " + str(add_score))
	score += add_score
	$HUD.update_score(score, add_score)
