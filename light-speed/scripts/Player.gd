extends Node


var velocity
const max_velocity = 0.125


func _ready():
	$PlayerShip/AnimatedSprite.animation = "idle"
	velocity = 0
	update_position_easy()


# TODO: adjust the multipliers to delta for best inherce feeling & control
# TODO: improve ship jump by adding its own animation & sound
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		$PlayerShip.position += new_position()
		update_position_easy()
	elif Input.is_action_pressed("ui_right"):
		$PlayerShip/AnimatedSprite.animation = "turn_left"
		velocity = min(velocity + (delta * 0.25), max_velocity)
	elif Input.is_action_pressed("ui_left"):
		$PlayerShip/AnimatedSprite.animation = "turn_right"
		velocity = max(velocity - (delta * 0.25), -max_velocity)
	else:
		$PlayerShip/AnimatedSprite.animation = "idle"
		if velocity > 0:
			velocity = max(velocity - (delta * 0.25), 0)
		elif velocity < 0:
			velocity = min(velocity + (delta * 0.25), 0)
	if velocity != 0:
		$PlayerShip.rotation += velocity
		# Make rotation between [0,2*PI]
		if $PlayerShip.rotation > 2 * PI:
			$PlayerShip.rotation -= 2 * PI 
		elif $PlayerShip.rotation < 0:
			$PlayerShip.rotation += 2 * PI
		update_position_easy()
	#print(str(rotation))


func update_position_easy():
	var new_pos = new_position()
	#print(str($PlayerShip.rotation) + ' ' + str(new_pos))
	$PlayerShipNext.rotation = $PlayerShip.rotation
	$PlayerShipNext.position = $PlayerShip.position + new_pos


# TODO: find out why the ship's position starts deviating from the center of the hexagon
# after some displacements
func new_position():
	var new_pos
	if $PlayerShip.rotation >= (PI / 12) && $PlayerShip.rotation < (PI / 4):
		new_pos = Vector2(128,-192)
	elif $PlayerShip.rotation >= (PI / 4) && $PlayerShip.rotation < ((5 * PI) / 12):
		new_pos = Vector2(192,-92)
	elif $PlayerShip.rotation >= ((5 * PI) / 12) && $PlayerShip.rotation < ((7 * PI) / 12):
		new_pos = Vector2(256,0)
	elif $PlayerShip.rotation >= ((7 * PI) / 12) && $PlayerShip.rotation < ((3 * PI) / 4):
		new_pos = Vector2(192,92)
	elif $PlayerShip.rotation >= ((3 * PI) / 4) && $PlayerShip.rotation < ((11 * PI) / 12):
		new_pos = Vector2(128,192)
	elif $PlayerShip.rotation >= ((11 * PI) / 12) && $PlayerShip.rotation < ((13 * PI) / 12):
		new_pos = Vector2(0,192)
	elif $PlayerShip.rotation >= ((13 * PI) / 12) && $PlayerShip.rotation < ((5 * PI) / 4):
		new_pos = Vector2(-128,192)
	elif $PlayerShip.rotation >= ((5 * PI) / 4) && $PlayerShip.rotation < ((17 * PI) / 12):
		new_pos = Vector2(-192,92)
	elif $PlayerShip.rotation >= ((17 * PI) / 12) && $PlayerShip.rotation < ((19 * PI) / 12):
		new_pos = Vector2(-256,0)
	elif $PlayerShip.rotation >= ((19 * PI) / 12) && $PlayerShip.rotation < ((7 * PI) / 4):
		new_pos = Vector2(-192,-92)
	elif $PlayerShip.rotation >= ((7 * PI) / 4) && $PlayerShip.rotation < ((23 * PI) / 12):
		new_pos = Vector2(-128,-192)
	else: # $PlayerShip.rotation in [(23 * PI) / 12, PI / 12)
		new_pos = Vector2(0,-192)
	return new_pos


func set_position(pos):
	$PlayerShip.position = pos
	update_position_easy()

