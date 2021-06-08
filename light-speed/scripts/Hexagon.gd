extends Area2D


enum {DAMAGE, SCORE_0, SCORE_1, SCORE_2, EMPTY}

var type
var score
var time

signal damaged
signal scored(add_score)


func _ready():
	if type == null:
		set_type(DAMAGE)
	time = 0


# TODO: fix this mess
func _process(delta):
	time +=  delta
	if time >= (2 * PI):
		time = time - (2 * PI)
	var min_scale = (sin(time) / 2) * 0.25
	#print(str(min_scale))
	#scale = scale - Vector2(min_scale,min_scale)
	return # change the size of the triangle with time 


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
	var rand_frame = randi() % $AnimatedSprite.get_sprite_frames().get_frame_count("damage")
	$AnimatedSprite.set_frame(rand_frame)


func get_type():
	return type


func _on_Triangle_area_entered(area):	
	if type == DAMAGE:
		emit_signal("damaged")
	elif type != EMPTY:
		emit_signal("scored", score)
