extends Node

var easy
var velocity
const max_velocity = 0.125


func _ready():
	$PlayerShip/AnimatedSprite.animation = "idle"
	velocity = 0
	easy = true
	update_position_easy()
	$PlayerShip.hide()
	$PlayerShipNext.hide()


# TODO: adjust the multipliers to delta for best inherce feeling & control
# TODO: improve ship jump by adding its own animation & sound
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		$PlayerShip.position += new_position()
		if easy:
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
		if easy:
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


func start_game(dif, pos):
	easy = dif
	velocity = 0
	$PlayerShip.position = pos
	$PlayerShip.rotation = 0
	$PlayerShip.show()
	if easy:
		$PlayerShipNext.show()
		update_position_easy()
	# If done inmediatly player collides with previous hexagon type, look if this can be handle better
	yield(get_tree().create_timer(0.001), "timeout")
	$PlayerShip/CollisionShape2D.disabled = false

# TODO: fix destroyed animation not working, this happens because the update function changes to idle
func game_over():
	$PlayerShip/AnimatedSprite.animation = "destroyed"
	$PlayerShip/CollisionShape2D.set_deferred("disabled", true)
	if (easy):
		$PlayerShipNext.hide()
	yield(get_tree().create_timer(4), "timeout")
	$PlayerShip.hide()


func trigger_hexagon():
	# Each time hexagons types are updated we force the player to trigger the current one,
	# maybe there's a better way to do this?
	$PlayerShip/CollisionShape2D.disabled = true
	$PlayerShip/CollisionShape2D.disabled = false

