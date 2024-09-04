extends CanvasLayer

@onready var experience: ProgressBar = $Control/Experience
@onready var health: ProgressBar = $Control/Health
@onready var level_up_notice: PanelContainer = $Control/LevelUpNotice

func _ready():
	PlayerStats.level_up.connect(level_up)
	PlayerStats.take_damage.connect(update_health)
	PlayerStats.add_xp.connect(update_xp)
	

func level_up():
	update_xp()
	level_up_notice.visible = true

func update_xp():
	experience.max_value = PlayerStats.next_level
	experience.value = PlayerStats.player_experience
	

func update_health():
	health.max_value = PlayerStats.player_max_health
	health.value = PlayerStats.player_health





func _on_level_up_notice_visibility_changed() -> void:
	if level_up_notice.visible == true:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_btn_health_level_pressed() -> void:
	PlayerStats.add_max_health()
	level_up_notice.visible = false


func _on_btn_gun_level_pressed() -> void:
	ProjectileBullet.level_up_bullet()
	level_up_notice.visible = false


func _on_btn_speed_level_pressed() -> void:
	pass # Replace with function body.
