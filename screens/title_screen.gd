extends Node2D

func _ready() -> void:
	print('title screen')
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://screens/intro-screen.tscn")
	pass
