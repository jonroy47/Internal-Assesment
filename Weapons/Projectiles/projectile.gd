class_name Projectile
extends Area2D

@export var initial_velocity : float = 300
var speed = 300

func launch(p_move_direction : Vector2):
#	linear_velocity = initial_velocity * p_move_direction
	look_at(get_global_mouse_position())
	
func _process(delta):
	position += transform.x * speed * delta

	#linear_velocity = initial_velocity
