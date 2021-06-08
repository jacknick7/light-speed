extends Area2D


enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}

export var type = DAMAGE
export var score = 0

signal damaged
signal scored(add_score)

func _process(delta):
	return # change the size of the triangle with time 


func set_triangle_type(new_type):
	type = new_type
	var type_str
	match type:
		DAMAGE:
			type_str = "damage"
			score = 0
		SCORE_0:
			type_str = "score0"
			score = 100
		SCORE_1:
			type_str = "score1"
			score = 250
		SCORE_2:
			type_str = "score2"
			score = 600
		EMPTY:
			type_str = "empty"
			score = 0
	$AnimatedSprite.animation = type_str
	$AnimatedSprite.frame = randi() % $AnimatedSprite.get_sprite_frames().get_frame_count("damage")


func _on_Triangle_area_entered(area):	
	if type == DAMAGE:
		emit_signal("damaged")
	elif type != EMPTY:
		emit_signal("scored", score)
