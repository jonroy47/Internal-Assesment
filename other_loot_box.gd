extends Area2D


# Called when the node enters the scene tree for the first time.
func collected():
	var vanish = preload("res://LootBox.tscn")
	var new_vanish_object = vanish.instantiate()
	get_tree().current_scene.add_child(new_vanish_object)


func _on_body_entered(body):
	if body.is_in_group("Car"):
		collected()
		call_deferred('free')
