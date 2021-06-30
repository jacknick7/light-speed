extends TextureRect


func _ready():
	var screen_size = get_viewport().size
	randomize()
	var id = randi() % 6
	texture = load("res://textures/background/"+str(screen_size.y)+"/background_"+str(id)+".jpg")
	print(str(id))
