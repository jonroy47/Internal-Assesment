class_name Shooter
extends Node2D

@export var fireable : Fireable
@export var group_names : GroupNames

var projectiles_parent : Node

func _ready():
	projectiles_parent = get_tree().get_first_node_in_group(group_names.projectiles_parent_group)
	assert(projectiles_parent != null)
	

func _shoot():
	var projectile = fireable.scene.instantiate() as Projectile
	projectiles_parent.add_child(projectile)
	projectile.global_position = global_position
