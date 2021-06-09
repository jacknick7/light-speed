extends Node


export (PackedScene) var Hexagon
var hexagon_matrix = []

enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}
var hexagon_prob = [DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,SCORE_0,
SCORE_1,SCORE_2,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE]


func _ready():
	build_matrix()


# TODO: fix the limits (x,y) where some empty spaces may appear (look at the bottom)
# TODO: add minimum space between hexagons to avoid trigger signal
func build_matrix():
	var screen_size = get_viewport().size
	var hexagons_n = int(screen_size.y / 96)
	var hexagons_m = int(screen_size.x / 128)
	if (hexagons_m + 1) * 128 - 64 <= screen_size.x:
		hexagons_m += 1
	if (hexagons_n + 1) * 96 - 64 <= screen_size.y:
		hexagons_n += 1
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


func make_choice():
	var i = randi() % hexagon_prob.size()
	return hexagon_prob[i]


func _on_Timer_timeout():
	for hexagon in hexagon_matrix:
		if hexagon.get_type() == DAMAGE || hexagon.get_type() == EMPTY:
			hexagon.set_type(make_choice())
		else:
			hexagon.set_type(EMPTY)

