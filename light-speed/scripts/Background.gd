extends TextureRect


var id


func _ready():
	var screen_size = get_viewport().size
	randomize()
	id = randi() % 6
	texture = load("res://textures/background/"+str(screen_size.y)+"/background_"+str(id)+".jpg")
	#print(str(id))


func change_resolution(new_res):
	texture = load("res://textures/background/"+str(new_res)+"/background_"+str(id)+".jpg")
	print("res://textures/background/"+str(new_res)+"/background_"+str(id)+".jpg")
