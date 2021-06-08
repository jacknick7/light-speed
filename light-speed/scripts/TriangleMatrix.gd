extends Node


export (PackedScene) var Triangle
var triangle_matrix = []

enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}
var triangle_prob = [DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,SCORE_0,
SCORE_1,SCORE_2,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE]


func _ready():
	build_matrix()


# TODO: fix the limits (x,y) where some empty spaces may appear (look at the bottom)
func build_matrix():
	var screen_size = get_viewport().size
	var triangles_n = int(screen_size.y / 96)
	var triangles_m = int(screen_size.x / 128)
	if (triangles_m + 1) * 128 - 64 <= screen_size.x:
		triangles_m += 1
	if (triangles_n + 1) * 96 - 64 <= screen_size.y:
		triangles_n += 1
	for i in range(triangles_n):
		for j in range(triangles_m):
			var triangle = Triangle.instance()
			var pos_x = j * 128
			if i % 2 != 0:
				pos_x += 64
			var pos_y = i * 96
			triangle.position = Vector2(pos_x,pos_y)
			triangle.set_type(make_choice())
			triangle_matrix.append(triangle)
			add_child(triangle)


func make_choice():
	var i = randi() % triangle_prob.size()
	return triangle_prob[i]


func _on_Timer_timeout():
	for triangle in triangle_matrix:
		if triangle.get_type() == DAMAGE || triangle.get_type() == EMPTY:
			triangle.set_type(make_choice())
		else:
			triangle.set_type(EMPTY)

