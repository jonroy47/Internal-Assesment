extends Sprite2D

func _physics_process(delta: float):
	look_at(get_global_mouse_position())
	
# This makes the bullet go towards the mouse on screen that you control
