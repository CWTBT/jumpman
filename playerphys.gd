extends KinematicBody2D

const GRAVITY = 1000
const MAX_SPEED = 600
const ACCEL = 1000
const DECEL = 2000
const J_FORCE = 600

var velocity = Vector2()
var speed_x = 0
var speed_y = 0
var moving = false
var last_left = false


func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _input(event):
	var jump = event.is_action_pressed("jump")
	if jump:
		speed_y = -J_FORCE
	
func _fixed_process(delta):
	var move_right = Input.is_action_pressed("move_right")
	var move_left = Input.is_action_pressed("move_left")
	
	if move_left:
		moving = true
		last_left = true
	if move_right:
		last_left = false
		moving = true
	if !move_left and !move_right:
		moving = false
	
	if moving:
		speed_x += ACCEL * delta
	else: speed_x -= DECEL * delta
	
	speed_y += delta * GRAVITY
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	velocity.y = speed_y * delta 
	velocity.x = speed_x * delta
	if last_left: velocity.x *= -1
	var remainder = move(velocity)
	
	if is_colliding():
		var normal = get_collision_normal()
		var final_move = normal.slide(remainder)
		if normal == Vector2(0,-1) or normal == Vector2(0,1):
			speed_y = 0
		move(final_move)