extends Node


export (PackedScene) var Triangle
var triangle_matrix = []

enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}
var triangle_prob = [DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,SCORE_0,
SCORE_1,SCORE_2,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,DAMAGE,]


func _ready():
	build_matrix()
	

func build_matrix():
	var screen_size = get_viewport().size
	var matrix_offset = screen_size * 0.01
	print(matrix_offset)
	var n_triangles = int((screen_size.y - (matrix_offset.y * 2)) / 104.4) #added +2.0 to triangle height for margins
	var m_triangles = int((screen_size.x - (matrix_offset.x * 2)) / 206.8) #added +2.0 to triangle height for margins
	matrix_offset = (screen_size - Vector2(206.8*m_triangles,104.4*n_triangles)) / 2
	print(matrix_offset)
	for i in range(n_triangles):
		for j in range(m_triangles):
			var triangle = Triangle.instance()
			triangle.set_name("Triangle"+str(i)+str(j)) #No need for this. Maybe?
			var posx = matrix_offset.x + 103.4 + 206.8 * j
			var posy = matrix_offset.y + 52.2 + 104.4 * i
			triangle.position = Vector2(posx,posy)
			triangle.set_triangle_type(make_choice())
			triangle_matrix.append(triangle)
			add_child(triangle)
			if j < (m_triangles-1): # Think in a better way to add the inverse triangles
				triangle = Triangle.instance()
				triangle.set_name("Triangle_I"+str(i)+str(j)) #No need for this. Maybe?
				triangle.scale.y =-1
				posx += 103.4
				triangle.position = Vector2(posx,posy)
				triangle.set_triangle_type(make_choice())
				triangle_matrix.append(triangle)
				add_child(triangle)				
	triangle_matrix[4].set_triangle_type(SCORE_0)


func make_choice():
	var i = randi() % triangle_prob.size()
	return triangle_prob[i]
