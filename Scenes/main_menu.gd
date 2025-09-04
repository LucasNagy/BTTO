extends Node
@onready var global = $"/root/Global"

func _ready():
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(2.4).timeout
	$AnimationPlayer.play("loop")
	$FADE.visible = false
		

func _on_start_pressed():
	global.hp = 5
	global.points = 0
	get_tree().change_scene_to_file("res://Scenes/transition.tscn")
	
func start_music():
	if !$Music.is_playing():
		$Music.play()


func _on_ctrl_pressed():
	global.hp = 69
	global.points = 0
	get_tree().change_scene_to_file("res://Scenes/transitionB.tscn")
