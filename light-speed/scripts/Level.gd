extends Node


var ini_position


func _ready():
	randomize()
	ini_position = $HexagonMatrix.build_matrix()
	print(str(ini_position))


func start_game(easy):
	print(easy)
	$HexagonMatrix.start_game()
	$Player.start_game(easy, ini_position)
	$Timer.start()


func _on_Timer_timeout():
	$HexagonMatrix.update_matrix()
