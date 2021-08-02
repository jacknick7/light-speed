extends Node


var ini_position
var score
var volume
var skip_intro


func _ready():
	randomize()
	volume = 50
	skip_intro = false
	$Background.initialize()
	ini_position = $HexagonMatrix.initialize()
	$Menu.initialize()
	$HUD.initialize()
	#print(str(ini_position))


# TODO: make the intro
func start_game(easy):
	#print(easy)
	if !skip_intro:
		print("Show intro here")
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
	$HUD.game_over()
	$HexagonMatrix.game_over(self)
	$Menu.game_over(score)


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


# TODO: change HexagonMatrix resolution
func _on_Menu_change_resolution(new_res):
	print(new_res)
	OS.set_window_size(new_res)
	print(get_viewport().size)


func _on_Menu_change_volume(new_vol):
	volume = new_vol
	print(str(volume))


func _on_Menu_skip_intro(new_skip):
	skip_intro = new_skip
