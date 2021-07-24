extends TextureRect


var id


func initialize():
	id = randi() % 6
	texture = load("res://textures/background/background_"+str(id)+".jpg")
	print(str(id))
