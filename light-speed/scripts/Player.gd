extends KinematicBody2D


var velocity
var max_velocity = 0.125


func _ready():
	$AnimatedSprite.animation = "idle"
	position = Vector2(500,500) # For testing, remove once done
	velocity = 0

# TODO: adjust the multipliers to delta for best inherce feeling & control
# TODO: add space Input makes ship jump
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.animation = "turn_left"
		velocity = min(velocity+(delta*0.25),max_velocity)
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.animation = "turn_right"
		velocity = max(velocity-(delta*0.25),-max_velocity)
	elif Input.is_action_just_pressed("ui_select"):
		var dis_rotation = rotation - (PI / 2)
		var new_direction = Vector2(cos(dis_rotation),sin(dis_rotation)) 
		# Normalize new_direction vector?
		var new_position = position + (new_direction * 192)
		# Here new_position must be converted to the center of the nearest hexagon
		position = new_position
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
	print(str(rotation))
