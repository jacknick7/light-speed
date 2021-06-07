extends Node


export (PackedScene) var Triangle
var screen_size
var triangle_matrix = []

enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}

func _ready():
	screen_size = get_viewport().size
	for i in range(10):
		for j in range(10):
			var triangle = Triangle.instance()
			triangle.set_name("Triangle"+str(i)+str(j))
			triangle.position = Vector2(51.2+51.2*i*2,51.2+51.2*j*2)
			triangle.set_triangle_type(DAMAGE)
			triangle_matrix.append(triangle)
			add_child(triangle)
	triangle_matrix[4].set_triangle_type(SCORE_0)
