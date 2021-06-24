extends Node


var ini_position
var score


func _ready():
	randomize()
	ini_position = $HexagonMatrix.build_matrix(self)
	#print(str(ini_position))


func start_game(easy):
	#print(easy)
	$HexagonMatrix.start_game()
	$Player.start_game(easy, ini_position)
	$UpdateTimer.start()
	$ScoreTimer.start()
	score = 0


func _on_UpdateTimer_timeout():
	$HexagonMatrix.update_matrix()
	$Player.trigger_hexagon()


func _on_ScoreTimer_timeout():
	score += 10
	$HUD.update_score(score, 0)

# TODO: look how to handle _on_Hexagon_damaged & _on_Hexagon_scored so it's only
# active between start_game & game_over
func _on_Hexagon_damaged():
	print("Damaged")


func _on_Hexagon_scored(add_score):
	print("Scored: " + str(add_score))
	score += add_score
	$HUD.update_score(score, add_score)
