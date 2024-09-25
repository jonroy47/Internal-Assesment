extends Node2D
@onready var spawn_points = $SpawnPoints.get_children()
@onready var spawn_timer: Timer = $SpawnTimer
@onready var world = get_node("/root/World")
@onready var camera = $".."
const ENEMY = preload("res://enemy.tscn")
# These are some variables that are used to store the data.
func spawn_enemy():
	var enemy = ENEMY.instantiate()
	var spawn_point = spawn_points.pick_random()
	enemy.global_position = spawn_point.global_position
	world.add_child(enemy)
# This is the random enemy spawning system. It will pick a random
# marker 2D on the left and spawn an enemy on it

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
#This is linked to the actual enemy script that will spawn the enemy.
