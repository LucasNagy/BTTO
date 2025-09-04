extends Node2D


func _ready():
	pass

func _physics_process(_delta):
	if Input.is_action_just_pressed("skip"):
		done()
	
func done():
	get_tree().change_scene_to_file("res://Scenes/end.tscn")
