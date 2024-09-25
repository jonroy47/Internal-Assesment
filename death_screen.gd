extends Control



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	global.health = 100
# This also makes it that when the button is presssed, it oges to the main menu. 
# The health is also sets the player health to 100 so you don't stay in a constat loop. 
