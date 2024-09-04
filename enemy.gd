extends CharacterBody2D

var player_inattack_zone = false
const EXPERIENCE_GEM = preload("res://experience_gem.tscn")
var speed = 200
var player_chase = false
var player = null
@onready var damage_timer: Timer = $HurtBox/DamageTimer

@export var health = 10
@export var damage = randf_range(10, 60)

func _physics_process(delta):
	check_collisions()
	if player_chase:
		position += (player.position - position)/speed

		$AnimatedSprite2D.play("walk")                         
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
	
	
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	


func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false
	


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("car"):
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("car"):
		player_inattack_zone = false
		
func deal_with_damage():
	pass
	move_and_slide()

func take_damage(dmg):
	health -= dmg
	if health <0:
		queue_free()
		var new_gem = EXPERIENCE_GEM.instantiate()
		new_gem.global_position = global_position
		add_sibling(new_gem)

func check_collisions():
	if not damage_timer.is_stopped():
		return
	var collisions = $HurtBox.get_overlapping_bodies()
	if collisions:
		for collision in collisions:
			if collision.is_in_group("Car") and damage_timer.is_stopped():
				PlayerStats.damage_player(damage)
				damage_timer.start()
