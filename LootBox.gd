extends Area2D


# Called when the node enters the scene tree for the first time.
func collected():
	pass
	


func _on_body_entered(body):
	if body.is_in_group("Car"):
		collected()
		queue_free()

# This is just a lootbox that when entering the hitbox for it, it will disappeae.
