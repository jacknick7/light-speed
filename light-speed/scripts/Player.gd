extends KinematicBody2D


var velocity
var max_velocity = 0.125


func _ready():
	$AnimatedSprite.animation = "idle"
	velocity = 0

# TODO: adjust the multipliers to delta for best inherce feeling & control
# TODO: add space Input makes ship jump
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		#var dis_rotation = rotation - (PI / 2)
		#var new_direction = Vector2(cos(dis_rotation),sin(dis_rotation)) 
		# Normalize new_direction vector?
		#var new_position = position + (new_direction * Vector2(256,192))
		# Here new_position must be converted to the center of the nearest hexagon
		position += new_position()
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite.animation = "turn_left"
		velocity = min(velocity+(delta*0.25),max_velocity)
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.animation = "turn_right"
		velocity = max(velocity-(delta*0.25),-max_velocity)
	else:
		$AnimatedSprite.animation = "idle"
		if velocity > 0:
			velocity = max(velocity-(delta*0.25),0)
		elif velocity < 0:
			velocity = min(velocity+(delta*0.25),0)
	if velocity != 0:
		rotation += velocity
		# Make rotation between [0,2*PI]
		if rotation > 2 * PI:
			rotation -= 2 * PI 
		elif rotation < 0:
			rotation += 2 * PI
		update_position_easy()
	#print(str(rotation))

# TODO: fix this
func update_position_easy():
	var new_pos = new_position()
	print(str(rotation) + ' ' + str(new_pos))
	$AnimatedSprite2.position = position + new_pos


func new_position():
	var new_pos
	if rotation >= (PI / 12) && rotation < (PI / 4):
		new_pos = Vector2(128,-192)
	elif rotation >= (PI / 4) && rotation < ((5 * PI) / 12):
		new_pos = Vector2(192,-92)
	elif rotation >= ((5 * PI) / 12) && rotation < ((7 * PI) / 12):
		new_pos = Vector2(256,0)
	elif rotation >= ((7 * PI) / 12) && rotation < ((3 * PI) / 4):
		new_pos = Vector2(192,92)
	elif rotation >= ((3 * PI) / 4) && rotation < ((11 * PI) / 12):
		new_pos = Vector2(128,192)
	elif rotation >= ((11 * PI) / 12) && rotation < ((13 * PI) / 12):
		new_pos = Vector2(0,192)
	elif rotation >= ((13 * PI) / 12) && rotation < ((5 * PI) / 4):
		new_pos = Vector2(-128,192)
	elif rotation >= ((5 * PI) / 4) && rotation < ((17 * PI) / 12):
		new_pos = Vector2(-192,92)
	elif rotation >= ((17 * PI) / 12) && rotation < ((19 * PI) / 12):
		new_pos = Vector2(-256,0)
	elif rotation >= ((19 * PI) / 12) && rotation < ((7 * PI) / 4):
		new_pos = Vector2(-192,-92)
	elif rotation >= ((7 * PI) / 4) && rotation < ((23 * PI) / 12):
		new_pos = Vector2(-128,-192)
	else: # rotation in [(23 * PI) / 12, PI / 12)
		new_pos = Vector2(0,-192)
	return new_pos
