extends Area2D

@export var sign_content = "SAMPLE TEXT"
@export var sign_width = 8
@export var sign_height = 8
@export var sign_dist = 90
@onready var camera = $"../CharacterBody2D/Camera2D"

func _ready():
	get_node("Panel").hide()
	

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		get_node("Panel/Label").text = sign_content
		get_node("Panel/Label/Stroke").text = sign_content
		get_node("Panel").show()
		get_node("Panel").size.x = get_node("Panel/Label").size.x + sign_width
		get_node("Panel").size.y = get_node("Panel/Label").size.y + sign_height
		get_node("Panel").position.y = get_node("Panel/Label").position.y - sign_dist
		

func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		get_node("Panel").hide()
