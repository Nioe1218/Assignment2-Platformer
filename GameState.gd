extends Node2D


onready var Player = $Player
onready var respawnPoint = $RespawnPoint
onready var starting_spawn = $StartingSpawn


func _ready():
	if Save.game_data.spawn:
		Player.global_position= Save.game_data.spawn
	else:
		Player.global_position= starting_spawn.global_position
	
func _process(delta):
	if Player.position.y >700:
		if Save.game_data.spawn:
			Player.global_position= Save.game_data.spawn
			
		else:
			Player.global_position= starting_spawn.global_position
			
	if Player.health == 0 :
		get_tree().change_scene("res://lose.tscn")
