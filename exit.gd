extends Area2D

export(String,FILE) var Level = "res://New Plaformer.tscn"


func _on_exit_body_entered(body):
	get_tree().change_scene(Level)
