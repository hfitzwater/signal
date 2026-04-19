extends CharacterBody2D

const BASE_SPEED = 100
const BASE_JUMP = -400
const BASE_GRAVITY = 2000

@export var speed = BASE_SPEED
@export var jump = BASE_JUMP
@export var gravity = BASE_GRAVITY
@export_range(0.0, 1.0) var skewage = 0.2
@export_range(0.0 , 1.0) var acceleration = 0.25

@onready var _anim = $AnimatedSprite2D

var power: float = 4
var treatsConsumed = 0
var empowered = false

var tween: Tween = null
var skewTarget = skewage
var lastDir = 0

func _ready() -> void:
	_anim.play("default")
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pass

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, 1)
	
	move_and_slide()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is Treat:
			_consume_treat(collider)
		elif collider is Trip:
			_hit_trip(collider)

func _consume_treat(treat: Treat):
	print('consume treat')
	treat.free()
	
	$ConsumeTimer.start(power)
	power -= 0.5
	
	empowered = true
	gravity = 180
	speed = BASE_SPEED * power
	jump = BASE_JUMP * (power/5)
	velocity.y = jump
	
	_anim.play("glowing")

func _on_ConsumeTimer_timeout():
	treatsConsumed += 1
	
	_anim.play("consumed" + str(treatsConsumed))
	
	empowered = false 
	gravity = BASE_GRAVITY
	speed = BASE_SPEED - (3 * treatsConsumed)
	jump = BASE_JUMP + (8 * treatsConsumed)
	
	if treatsConsumed >= 4:
		speed = 40
	
	pass
	
func _hit_trip(trip: Trip):
	trip.free()
	
	var tree = get_tree()
	
	if tree:
		tree.change_scene_to_file("res://screens/outro-screen.tscn")
	pass
