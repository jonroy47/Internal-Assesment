extends CharacterBody2D

@export var default_direction = Vector2.RIGHT

func _physics_process(delta: float):
	look_at(get_global_mouse_position())

# This makes the bullet go towards your mouse.
