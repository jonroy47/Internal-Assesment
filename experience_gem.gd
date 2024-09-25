extends Area2D

@export var experience_value = 5
var collected = false
@onready var player = get_tree().get_first_node_in_group("Car")

# Some variables


func _process(delta):
	if collected:
		if player:
			global_position = global_position.move_toward(player.global_position, 300 * delta)

# This makes the EXP orb go towards the player only if the player has come in contact with it.

func collect():
	collected = true
	
# Once collected, it will make a variable true.

func _on_body_entered(body):
	if body.is_in_group("Car"):
		queue_free()
# It will queue_free after it has entered the player's hibox.
