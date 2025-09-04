extends Timer
@onready var game_manager = %GameManager



func _on_timeout():
	game_manager.damage()
	get_tree().reload_current_scene()
