extends Node

var bullet_level = 1
var bullet_damage = 5
var bullet_speed = 200
var bullet_projectiles = 1
var bullet_time = 0.8
var bullet_knockback = 10

func level_up_bullet():
	bullet_level += 1
	match bullet_level:
		1:
			pass
		2:
			bullet_damage = 10
			bullet_speed = 200
			bullet_projectiles = 2
			bullet_time = 0.8
			bullet_knockback = 15
		3:
			bullet_damage = 15
			bullet_speed = 200
			bullet_projectiles = 2
			bullet_time = 0.5
			bullet_knockback = 20
