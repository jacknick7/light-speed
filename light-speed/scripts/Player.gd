extends Node


var playing
var easy
var velocity
var short_jump
const MAX_VELOCITY = 0.125
const ACC_VELOCITY = 0.25
const DACC_VELOCITY = 0.25
const ROT_POINTS = [
	PI / 12, PI / 4, (5 * PI) / 12, (7 * PI) / 12, (3 * PI) / 4, (11 * PI) / 12,
	(13 * PI) / 12, (5 * PI) / 4, (17 * PI) / 12, (19 * PI) / 12, (7 * PI) / 4,
	(23 * PI) / 12
]
signal screen_limits


func initialize():
	playing = false
	$PlayerShip.hide()
	$PlayerShipNext.hide()


# TODO: adjust the multipliers to delta for best inherce feeling & control
# TODO: improve ship jump by adding its own animation & sound
func _process(delta):
	if playing: handle_input(delta)


func handle_input(delta):
	if Input.is_action_just_pressed("ui_up"):
		short_jump = !short_jump
		if easy: update_position_easy()
	elif Input.is_action_just_pressed("ui_select"):
		var next_position = new_position()
		if is_inside_screen($PlayerShip.position + next_position):
			$PlayerShip.position += next_position
			if easy: update_position_easy()
		else: emit_signal("screen_limits")
	elif Input.is_action_pressed("ui_right"):
		if $PlayerShip/AnimatedSprite.animation != "turn_left": $PlayerShip/AnimatedSprite.animation = "turn_left"
		velocity = min(velocity + (delta * ACC_VELOCITY), MAX_VELOCITY)
	elif Input.is_action_pressed("ui_left"):
		if $PlayerShip/AnimatedSprite.animation != "turn_right": $PlayerShip/AnimatedSprite.animation = "turn_right"
		velocity = max(velocity - (delta * ACC_VELOCITY), -MAX_VELOCITY)
	else:
		if $PlayerShip/AnimatedSprite.animation != "idle": $PlayerShip/AnimatedSprite.animation = "idle"
		if velocity > 0: velocity = max(velocity - (delta * DACC_VELOCITY), 0)
		elif velocity < 0: velocity = min(velocity + (delta * DACC_VELOCITY), 0)
	if velocity != 0:
		$PlayerShip.rotation += velocity
		# Make rotation between [0,2*PI]
		if $PlayerShip.rotation > 2 * PI: $PlayerShip.rotation -= 2 * PI 
		elif $PlayerShip.rotation < 0: $PlayerShip.rotation += 2 * PI
		if easy: update_position_easy()


func update_position_easy():
	var new_pos = new_position()
	$PlayerShipNext.rotation = $PlayerShip.rotation
	$PlayerShipNext.position = $PlayerShip.position + new_pos


func is_inside_screen(pos):
	if (pos.x < 0) || (pos.y < 0): return false
	var screen_size = get_viewport().size
	if (pos.x > screen_size.x) || (pos.y > screen_size.y): return false
	return true


func new_position():
	var new_pos
	var ps_rot = $PlayerShip.rotation
	if short_jump:
		pass
	else:
		if ps_rot >= ROT_POINTS[0] && ps_rot < ROT_POINTS[1]: new_pos = Vector2(128,-192)
		elif ps_rot >= ROT_POINTS[1] && ps_rot < ROT_POINTS[2]: new_pos = Vector2(192,-96)
		elif ps_rot >= ROT_POINTS[2] && ps_rot < ROT_POINTS[3]: new_pos = Vector2(256,0)
		elif ps_rot >= ROT_POINTS[3] && ps_rot < ROT_POINTS[4]: new_pos = Vector2(192,96)
		elif ps_rot >= ROT_POINTS[4] && ps_rot < ROT_POINTS[5]: new_pos = Vector2(128,192)
		elif ps_rot >= ROT_POINTS[5] && ps_rot < ROT_POINTS[6]: new_pos = Vector2(0,192)
		elif ps_rot >= ROT_POINTS[6] && ps_rot < ROT_POINTS[7]: new_pos = Vector2(-128,192)
		elif ps_rot >= ROT_POINTS[7] && ps_rot < ROT_POINTS[8]: new_pos = Vector2(-192,96)
		elif ps_rot >= ROT_POINTS[8] && ps_rot < ROT_POINTS[9]: new_pos = Vector2(-256,0)
		elif ps_rot >= ROT_POINTS[9] && ps_rot < ROT_POINTS[10]: new_pos = Vector2(-192,-96)
		elif ps_rot >= ROT_POINTS[10] && ps_rot < ROT_POINTS[11]: new_pos = Vector2(-128,-192)
		else:  new_pos = Vector2(0,-192) # $PlayerShip.rotation in [(23 * PI) / 12, PI / 12)
	return new_pos


func start_game(diff, pos):
	easy = diff
	playing = true
	velocity = 0
	short_jump = false
	$PlayerShip.position = pos
	$PlayerShip.rotation = 0	
	$PlayerShip/AnimatedSprite.animation = "idle"
	$PlayerShip.show()
	if easy:
		update_position_easy()
		$PlayerShipNext.show()
	# If done inmediatly player collides with previous hexagon type, look if this can be handle better
	yield(get_tree().create_timer(0.001), "timeout")
	$PlayerShip/CollisionShape2D.disabled = false


func game_over():
	playing = false
	$PlayerShip/AnimatedSprite.animation = "destroyed"
	$PlayerShip/CollisionShape2D.set_deferred("disabled", true)
	if easy: $PlayerShipNext.hide()
	yield(get_tree().create_timer(4), "timeout")
	$PlayerShip.hide()


func trigger_hexagon():
	# Each time hexagons types are updated we force the player to trigger the current one,
	# maybe there's a better way to do this?
	$PlayerShip/CollisionShape2D.set_deferred("disabled", true)
	$PlayerShip/CollisionShape2D.set_deferred("disabled", false)

