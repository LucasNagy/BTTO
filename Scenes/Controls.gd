extends Panel
@onready var ctrl = $"../CTRL"
@onready var x = $X



func _on_ctrl_pressed():
	visible = true


func _on_x_pressed():
	visible = false
