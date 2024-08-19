class_name Projectile
extends RigidBody2D

@export var initial_velocity : float = 300


func launch(p_move_direction : Vector2):
	linear_velocity = initial_velocity * p_move_direction
