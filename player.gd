extends CharacterBody2D
class_name Player

@export var speed : float
@export var accel_time : float
@export var dash_speed : float

@onready var accel : float = speed / accel_time

var direction : Vector2

func _physics_process(delta):
	look_at(get_global_mouse_position())
	direction = Vector2(Input.get_axis('left', 'right'), Input.get_axis('up', 'down'))
	velocity = velocity.move_toward((Vector2(1, 1) * direction).normalized() * speed, accel * delta)
	move_and_slide()
