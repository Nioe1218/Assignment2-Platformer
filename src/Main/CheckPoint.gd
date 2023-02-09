extends Area2D

onready var animation_player =$AnimationPlayer

func _on_CheckPoint_body_entered(body):
	Save.game_data.spawn = global_position
	Save.save_data()
	animation_player.play("active")
