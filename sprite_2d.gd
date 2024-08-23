extends Sprite2D

func _physics_process(delta: float):
	look_at(get_global_mouse_position())
	
