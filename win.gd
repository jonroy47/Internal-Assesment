extends Control
@onready var button: Button = $Button




func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	global.points = 0
	global.health = 100
	
# This is the winning screen that when the button is clicked, you will go to the main mwnu where you can replay.
# It also sets the points to 0 and health to 100 to make sure you don't start with 30 points and win again.
