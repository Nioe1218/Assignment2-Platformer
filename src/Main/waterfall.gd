extends Area2D



func _on_waterfall_body_entered(body:KinematicBody2D)->void:
	body.go_to_checkpoint()
