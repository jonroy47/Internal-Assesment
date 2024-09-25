extends Control



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")
	
# This makes it that when a button is pressed, it goes to the main world menu.
