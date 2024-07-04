extends CharacterBody2D
var acceleration = Vector2.ZERO
var engine_power = 500
var friction = -0.9
var drag = -0.001
var braking = -450
var max_speed_reversed = 250
var slip_speed = 250
var traction_fast = 0.1
var traction_slow = 0.8
# When the Car fets up to speed, i.e. traction_fast, the car will lose traction
# so it looks like it is drifting or sliding.
var wheel_base = 70
var steering_angle = 30
var steer_direction 

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()

func get_input():
	var turn = 0
	if Input.is_action_pressed("right"):
		turn += 1
	if Input.is_action_pressed("left"):
		turn -= 1
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("forward"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("backward"):
		acceleration = transform.x * braking
	if Input.is_action_pressed("powerslide"):
		traction_fast = 0.001
		traction_slow = 0.1
		steering_angle = 60
	else:
		traction_fast = 0.1
		traction_slow = 0.8
		steering_angle = 30
# This is Powerslide so you will drift  if you press down 'SHIFT'

func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/2.0
	var front_wheel = position + transform.x * wheel_base/2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.lerp(new_heading * velocity.length(), traction)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reversed)
	rotation = new_heading.angle()
	
func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force
