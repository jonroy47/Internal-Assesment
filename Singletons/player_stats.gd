extends Node

var player_level = 1
var player_experience = 0
var player_health = 100
var player_max_health = 100
var next_level = 15

signal level_up

func level_up_player():
	player_level += 1
	next_level = next_level + 10
	player_experience = 0
	emit_signal("level_up")
	

func add_experience(val):
	player_experience += val
	if player_experience >= next_level:
		level_up_player()
