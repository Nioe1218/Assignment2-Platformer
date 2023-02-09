extends Area2D

export(String,FILE) var v = "res://victory Screen.tscn"


func _on_exit_body_entered(body):
	get_tree().change_scene(v)
