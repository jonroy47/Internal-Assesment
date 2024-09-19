class_name Projectile
extends Area2D

@export var initial_velocity : float = 300
var speed = 300

func launch(p_move_direction : Vector2):
	look_at(get_global_mouse_position())
# This code is for the bullet propelling towards the cursor 

func _process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.take_damage(ProjectileBullet.bullet_damage)
		queue_free()
# This is when the bullet colides with the collision of an
# enemy, the bullet deletes itself.
