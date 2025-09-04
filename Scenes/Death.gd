extends Area2D

@onready var game_manager = %GameManager
@onready var player = $"../CharacterBody2D"
@onready var global = $"/root/Global"

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		if global.hp == 1:
			get_tree().change_scene_to_file("res://Scenes/dead.tscn")
		else:
			game_manager.damage()
			# level 1 checkpoints
			if get_tree().current_scene.name == "level0":
				if player.position.x < 5900:
					player.respawn()
					player.position.x = 0
					player.position.y = 64.08435
				if player.position.x < 9350 and player.position.x > 5900:
					player.respawn()
					player.position.x = 5006
					player.position.y = -151.9898
				if player.position.x < 9550 and player.position.x > 9350:
					player.respawn()
					player.position.x = 8836
					player.position.y = -367.9897
				if player.position.x > 10930:
					player.respawn()
					player.position.x = 10376
					player.position.y = -367.991
			
			# level 2 checkpoints
			if get_tree().current_scene.name == "level1":
				if player.position.x < 9999999999:
					player.respawn()
					player.position.x = 4387
					player.position.y = 64
					
			# level 3 checkpints
			if get_tree().current_scene.name == "level2":
				if player.position.x < 2570:
					player.respawn()
					player.position.x = 714
					player.position.y = -655.991
				if player.position.x < 5300 and player.position.x > 2570:
					player.respawn()
					player.position.x = 3258
					player.position.y = -1807.99
				if player.position.x < 7500 and player.position.x > 5300:
					player.respawn()
					player.position.x = 5002
					player.position.y = -1735.99
				if player.position.x > 7500:
					player.position.x = 7080.5
					player.position.y = -223.99
			
			# level bonus checkpoints
			if get_tree().current_scene.name == "levelbonus":
				player.position.x = 0
				player.position.y = -200
