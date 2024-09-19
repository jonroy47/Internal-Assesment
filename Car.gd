extends CharacterBody2D

const TEST_POSITION = preload("res://test_position.tscn")

var is_ready: bool = true
var acceleration = Vector2.ZERO
var engine_power = 300
var friction = -0.9
var drag = -0.001
var braking = -450
var max_speed_reversed = 100
var slip_speed = 200
var traction_fast = 0.09
var traction_slow = 0.9
# When the Car fets up to speed, i.e. traction_fast, the car will lose traction
# so it looks like it is drifting or sliding.
var wheel_base = 70
var steering_angle = 40
var steer_direction 

#These are all the variables I have in my game that are to do with the car

@export var projectile: PackedScene
@onready var spawn_point: Marker2D = $Marker2D
const BASIC_PROJECTILE = preload("res://Weapons/Projectiles/basic_projectile.tscn")
@export var shooter : Shooter
@onready var Shoot_Timer =  $Projectile_Timer
var attack_ip = false

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()
	enemy_attack()
	if Input.is_action_pressed("attack") and is_ready:
		Shoot_Timer = false
		is_ready = false
		$Projectile_Timer.start()
		shooter._shoot()
	# This is how when the player presses the attack button, (Left Click)
	# a bullet will be spawned. This is using the _shoot function which is
	# another cuntion linked somewhere else.
	
	if global.health <= 0:
		player_alive = false #This is where you would add the end screen...
		global.health = 0
		print(global.health, "Player has been killed")
		self.queue_free()
		get_tree().change_scene_to_file("res://death_screen.tscn")
		# This is that when the player hits below 0 health, the player will
		# be sent to another scene which will say 'Respawn.'
		
func get_input():
	var turn = 0
	if Input.is_action_pressed("right"):
		turn += 1
	# This turns the car right
	if Input.is_action_pressed("left"):
		turn -= 1
	# This turns the car left
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("forward"):
		acceleration = transform.x * engine_power
	# This proppels the car forward
	if Input.is_action_pressed("backward"):
		acceleration = transform.x * braking
	# This makes the car go backwards
	if Input.is_action_pressed("powerslide"):
		traction_fast = 0.001
		traction_slow = 0.1
		steering_angle = 90
	else:
		traction_fast = 0.1
		traction_slow = 0.8
		steering_angle = 40
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
	

func player():
	pass
	



func apply_friction():
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force
	



func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true



func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false


func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		global.health -= 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(global.health)



func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	


func _on_projectile_timer_timeout() -> void:
	is_ready = true

func test():
	position = Vector2(0, 9)
	


func _on_pickup_zone_area_entered(area):
	if area.is_in_group("Pickup"):
		if area.has_method("collect"):
			area.collect()
			
			
