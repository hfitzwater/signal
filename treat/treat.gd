extends RigidBody2D

class_name Treat

var tween: Tween = null

func _ready() -> void:
	animate()

func animate():
	if tween:
		tween.kill()
	
	# pulse
	tween = create_tween().set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($Sprite2D, "scale", Vector2(2.8, 2.8), 0.2)
	tween.tween_property($Sprite2D, "scale", Vector2(2.0, 2.0), 0.5)
