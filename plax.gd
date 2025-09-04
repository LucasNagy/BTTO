extends Sprite2D

@export var layer = 1
var speedOffset = -0.02
@onready var player = $"../../CharacterBody2D"

var posOffset : Vector2

func _ready():
	posOffset = position

func _process(_delta):
	position = -player.position * layer * speedOffset + posOffset
	if position.x - player.position.x > 1384:
		posOffset.x -= 2768
	if position.x - player.position.x < -1384:
		posOffset.x += 2768
