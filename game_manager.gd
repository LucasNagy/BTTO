extends Node
@onready var points_label = %PointsLabel
@onready var label_stroke = %LabelStroke
@onready var finish = $"../Level/Finish"
@onready var hp_label = %HPLabel
@onready var hp_stroke = %HPStroke
@onready var dead = $"../dead"
@onready var paper = $"../paper"
@onready var sigh = $"../sigh"
@onready var death = $"../Level/Death"
@onready var global = $"/root/Global"

#var hp = 3

#var points = 0

func _ready():
	if get_tree().current_scene.name == "level1":
		sigh.play()
	if get_tree().current_scene.name == "level2":
		sigh.play()

func damage():
	dead.play()
	global.hp -= 1
	hp_label.text = str(0) + str(global.hp)
	hp_stroke.text = hp_label.text

func add_point():
	paper.play()
	global.points += 1
	print(global.points)
	points_label.text = str(global.points)
	label_stroke.text = points_label.text
	finish.check_points()
