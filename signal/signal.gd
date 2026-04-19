extends Node2D

func _on_ready():
	$AnimatedSprite2D.play("default")

func _process(delta):
	$AnimatedSprite2D.play("default")
	pass
