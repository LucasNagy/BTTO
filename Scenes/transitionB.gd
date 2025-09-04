extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("falling2")
	

func done():
	get_tree().change_scene_to_file("res://Scenes/levelbonus.tscn")
