extends Area2D

# CollisionPolygon2D dimensions are 1px less than the size of the sprite to
# avoid trigger _on_Hexagon_area_entered() with other hexagons

enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}

var type
var score
var time
var original_scale

signal damaged
signal scored(add_score)


func initialize(new_pos, new_type):
	# Change initial time of each hexagon to generate a special effect with the breathing?
	time = 0
	original_scale = scale
	set_position(new_pos)
	set_type(new_type)


func _process(delta):
	breathing_effect(delta)


func breathing_effect(delta):
	# Breathing effect by modifing hexagon scale
	time += delta
	if time >= (2 * PI): time = time - (2 * PI)
	var offset_scale = 0.015 + (sin(time) * 0.015) # offset_scale: [0,0.3]
	scale = original_scale - Vector2(offset_scale,offset_scale)


func set_position(new_pos):
	position = new_pos

func set_type(new_type):
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
	$AnimatedSprite.set_animation(type_str)
	if not type == EMPTY: # Empty has no frames
		var n_frames = $AnimatedSprite.get_sprite_frames().get_frame_count(type_str)
		var rand_frame = randi() % n_frames
		$AnimatedSprite.set_frame(rand_frame)


func get_type():
	return type


func _on_Hexagon_body_entered(_body):
	print("player collide with hexagon of type " + str(type))
	if type == DAMAGE: emit_signal("damaged")
	elif type != EMPTY: emit_signal("scored", score)

