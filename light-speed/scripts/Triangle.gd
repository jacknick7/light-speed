extends Area2D


enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}

export var type = DAMAGE
export var score = 0

signal damaged
signal scored(add_score)


func set_triangle_type(new_type):
	type = new_type
	match type:
		DAMAGE:
			$AnimatedSprite.animation = "damage"
			score = 0
		SCORE_0:
			$AnimatedSprite.animation = "score0"
			score = 100
		SCORE_1:
			$AnimatedSprite.animation = "score1"
			score = 250
		SCORE_2:
			$AnimatedSprite.animation = "score2"
			score = 600
		EMPTY:
			$AnimatedSprite.animation = "empty"
			score = 0


func _on_Triangle_area_entered(area):	
	if type == DAMAGE:
		emit_signal("damaged")
	elif type != EMPTY:
		emit_signal("scored", score)
