extends CharacterBody2D

var wheel_base = 70
var steering_angle = 15


var steer_direction

func _physics_process(delta):

	get_input()
	calculate_steering(delta)

	move_and_slide()
	
func get_input():
	var turn = 0
	if Input.is_action_pressed('r'):
		turn += 1
	if Input.is_action_pressed('l'):
		turn -= 1
	steer_direction = turn * steering_angle
	velocity = Vector2.ZERO
	if Input.is_action_pressed('u'):
		velocity = transform.x * 100


func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/7.5
	var front_wheel = position + transform.x * wheel_base/7.5
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = (front_wheel - rear_wheel)
	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()
