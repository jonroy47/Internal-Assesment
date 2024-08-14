class_name Projectile
extends RigidBody2D

@export var initial_velocity : float = 300

func _ready():
	linear_velocity.x = initial_velocity
