extends Node2D


var ini_position


func _ready():
	ini_position = $HexagonMatrix.build_matrix()
	print(str(ini_position))


func _process(_delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		$Timer.start()
		$Player.position = ini_position


func _on_Timer_timeout():
	$HexagonMatrix.update_matrix()
