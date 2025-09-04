extends Label
@onready var timer = $"../../../Timer"
@onready var time_stroke = $TimeStroke


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	text = "%03d" % timer.time_left
	time_stroke.text = text
