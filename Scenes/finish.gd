extends Area2D

@export var target_level : PackedScene
@onready var points_label = %PointsLabel
@export var requirement = 0
@onready var sigh = $"../../sigh"

var points = 0

func check_points():
	points += 1

func _on_body_entered(body):
	if (body.name == "CharacterBody2D") and points > requirement:
		get_tree().change_scene_to_packed(target_level)
