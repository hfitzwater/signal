extends Node2D

func _ready() -> void:
	print('outro  screen')
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://screens/title-screen.tscn")
	pass
