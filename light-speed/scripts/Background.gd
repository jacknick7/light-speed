extends Node


func _ready():
	var screen_size = get_viewport().size
	var scale_x = screen_size.x / 512
	var scale_y = screen_size.y / 512
	$BackgroundColor.set_scale(Vector2(scale_x,scale_y))
	$BackgroundColor.set_position(Vector2(screen_size.x/2,screen_size.y/2))
	randomize()
	var id = randi() % 6
	$BackgroundColor.texture = load("res://textures/background/background_"+str(id)+".jpg")
	print(str(id))
