extends CharacterBody2D

var wheel_base = 70
var steering_angle = 15
var engine_power = 800

#new
var friction = -0.9
var drag = -0.001

var acceleration = Vector2.ZERO
#new
var steer_direction

func _physics_process(delta):
	acceleration = Vector2.ZERO
	#new
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity = acceleration * delta
	#new this is what the problem is for some reason
	move_and_slide()
	
func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force

func get_input():
	var turn = 0
	if Input.is_action_pressed('r'):
		turn += 1
	if Input.is_action_pressed('l'):
		turn -= 1
	steer_direction = turn * deg_to_rad(steering_angle)
	#taken away velocity = Vector2.ZERO
	if Input.is_action_pressed('u'):
		acceleration = transform.x * engine_power * 100
		# oldvelocity = transform.x * 100


func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/1.5
	var front_wheel = position + transform.x * wheel_base/1.5
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = (front_wheel - rear_wheel)
	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()
