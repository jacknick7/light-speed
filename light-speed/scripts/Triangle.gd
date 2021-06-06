extends Area2D


enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2}

export var type = DAMAGE
export var score = 0

signal damaged
signal scored(add_score)


func set_triangle_type(new_type):
	type = new_type
	match type:
		DAMAGE:
			$AnimatedSprite.animation = "damage"
		SCORE_0:
			$AnimatedSprite.animation = "score0"
			score = 100
		SCORE_1:
			$AnimatedSprite.animation = "score1"
			score = 250
		SCORE_2:
			$AnimatedSprite.animation = "score2"
			score = 600


func _on_Triangle_area_entered(area):	
	if type == DAMAGE:
		emit_signal("damaged")
	else:
		emit_signal("scored", score)
