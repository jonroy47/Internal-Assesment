extends CharacterBody2D

var player_inattack_zone = false
const EXPERIENCE_GEM = preload("res://experience_gem.tscn")
var speed = 200
var player_chase = false
var player = null

@export var health = 10

# These are the variables for the enemy.
func _physics_process(delta):

	if player_chase:
		position += (player.position - position)/speed

		$AnimatedSprite2D.play("walk")                         
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
	
	check_collisions()
	
# This code makes it that when the enemy flips direction, the animation flips too so that it looks like it is facing the car.


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	


func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false
	
# These two functions are for when the enemy is in or outside a hitbox of the player, they go towards it.
# Technically this is not needed for the enemy to folllow the car.

func enemy():
	pass
 

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("car"):
		player_inattack_zone = true



func _on_enemy_hitbox_body_exited(body):
	if body.has_method("car"):
		player_inattack_zone = false
		

# This is for when the enemy is in the hitbox of the player hitbox, it makes a variable true and vice versa.
# As shown down below, this will allow the enemy to deal damage 

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		health = health - 20
		print("Slime health = ", health)
		if health <= 0:
			self.queue_free()
	move_and_slide()
	# This move_and_slide() is the basically the main thing that makes this enemy move
	# This code is also for dealing damage to the player that takes away 20 from the global variable for player health.

func take_damage(dmg):
	health -= dmg
	if health <0:
		queue_free()
		var new_gem = EXPERIENCE_GEM.instantiate()
		new_gem.global_position = global_position
		add_sibling(new_gem)
		global.points +=1
		
# This is for when the enemy has 0 health, the enemy will die (queue_free() and drop the EXP orb. 


func check_collisions():
	if not $HurtBox/DamageTimer.is_stopped():
		return
	var collisions = $HurtBox.get_overlapping_bodies()
	if collisions:
		for collision in collisions:
			if collision.is_in_group("Car") and $HurtBox/DamageTimer.is_stopped():
				$HurtBox/DamageTimer.start()
				
# When the enemy deals damage, the timewr will restart.
