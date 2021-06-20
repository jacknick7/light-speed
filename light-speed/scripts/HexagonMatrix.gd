extends Node


export (PackedScene) var Hexagon
var hexagon_matrix = []

enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}
var hexagon_prob = [DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,SCORE_0,
SCORE_1,SCORE_2,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE]


#func _ready():
#	build_matrix()


# TODO: find out why get_viewport().size returns inacurate data when resolution is > 1080p
func build_matrix():
	var screen_size = get_viewport().size
	var hexagons_n = int(screen_size.y / 96) + 1
	var hexagons_m = int(screen_size.x / 128) + 1	
	#print("y: " + str(screen_size.y) + ' ' + str((hexagons_n-1)*96) + ' ' + str(hexagons_n))
	#print("x: " + str(screen_size.x) + ' ' + str((hexagons_m-1)*128) + ' ' + str(hexagons_m))
	if screen_size.x - ((hexagons_m - 1) * 128) - 64 > 0:
		hexagons_m += 1
	if screen_size.y - ((hexagons_n - 1) * 96) - 32 > 0:
		hexagons_n += 1	
	#print("y: " + str(screen_size.y) + ' ' + str((hexagons_n-1)*96) + ' ' + str(hexagons_n))
	#print("x: " + str(screen_size.x) + ' ' + str((hexagons_m-1)*128) + ' ' + str(hexagons_m))
	for i in range(hexagons_n):
		for j in range(hexagons_m):
			var hexagon = Hexagon.instance()
			var pos_x = j * 128
			if i % 2 != 0:
				pos_x += 64
			var pos_y = i * 96
			hexagon.position = Vector2(pos_x,pos_y)
			if i == int(hexagons_n / 2) && j == int(hexagons_m / 2):
				hexagon.set_type(EMPTY)
			else:
				hexagon.set_type(make_choice())
			hexagon_matrix.append(hexagon)
			add_child(hexagon)
	return Vector2(64 + int(hexagons_m / 2) * 128, int(hexagons_n / 2) * 96) # Fix the hardcoded 64


func make_choice():
	var i = randi() % hexagon_prob.size()
	return hexagon_prob[i]


func update_matrix():
	for hexagon in hexagon_matrix:
		if hexagon.get_type() == DAMAGE || hexagon.get_type() == EMPTY:
			hexagon.set_type(make_choice())
		else:
			hexagon.set_type(EMPTY)
