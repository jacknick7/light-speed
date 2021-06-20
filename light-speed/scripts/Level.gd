extends Node2D


var ini_position


func _ready():
	randomize()
	ini_position = $HexagonMatrix.build_matrix()
	$Player.set_position(ini_position)
	print(str(ini_position))


func _process(_delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		$Timer.start()


func _on_Timer_timeout():
	$HexagonMatrix.update_matrix()
