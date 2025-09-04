extends Sprite2D

@onready var player = $"../../CharacterBody2D"
# Called when the node enters the scene tree for the first time.
func _ready():
	posOffset = position

var posOffset : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x - player.position.x > 346:
		posOffset.x -= 692
	if position.x - player.position.x < -346:
		posOffset.x -= 692
