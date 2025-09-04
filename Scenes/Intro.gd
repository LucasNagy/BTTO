extends Node2D


func _ready():
	pass

func _physics_process(_delta):
	if Input.is_action_just_pressed("skip"):
		done1()
	
func done1():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
