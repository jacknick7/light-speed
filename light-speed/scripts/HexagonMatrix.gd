extends Node


export (PackedScene) var Hexagon
var hexagon_matrix = []
var hexagons_n
var hexagons_m

enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}
var hexagon_prob = [DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,SCORE_0,
SCORE_1,SCORE_2,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE]


# TODO: find out why get_viewport().size returns inacurate data when resolution is > 1080p
func initialize():
	var screen_size = get_viewport().size
	hexagons_n = int(screen_size.y / 96) + 1
	hexagons_m = int(screen_size.x / 128) + 1
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
			hexagon.set_type(make_choice())
			hexagon_matrix.append(hexagon)
			add_child(hexagon)
	var ini_pos = Vector2(int(hexagons_m / 2) * 128, int(hexagons_n / 2) * 96)
	if int(hexagons_n / 2) % 2 != 0:  # Add displacement of hexagon's center if row is even
		ini_pos.x += 64
	return ini_pos


func start_game(target_node):
	var mid_y = int(hexagons_n / 2)
	var mid_x = int(hexagons_m / 2)
	hexagon_matrix[mid_y * hexagons_m + mid_x].set_type(EMPTY)
	for hexagon in hexagon_matrix:
			hexagon.connect("damaged", target_node, "_on_Hexagon_damaged")
			hexagon.connect("scored", target_node, "_on_Hexagon_scored")


func game_over(target_node):
	for hexagon in hexagon_matrix:
		hexagon.disconnect("damaged", target_node, "_on_Hexagon_damaged")
		hexagon.disconnect("scored", target_node, "_on_Hexagon_scored")
		hexagon.set_type(make_choice())


func make_choice():
	var i = randi() % hexagon_prob.size()
	return hexagon_prob[i]


func update_matrix():
	for hexagon in hexagon_matrix:
		if hexagon.get_type() == DAMAGE || hexagon.get_type() == EMPTY:
			hexagon.set_type(make_choice())
		else:
			hexagon.set_type(EMPTY)
