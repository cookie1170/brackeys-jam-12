extends CharacterBody2D
class_name Player


@export var speed : float
@export var accel_time : float
@export var dash_speed : float
@export var health  : int

@onready var dash_cd : Timer = $DashCooldown
@onready var dash_buffer : Timer = $DashBuffer
@onready var accel : float = speed / accel_time

var direction : Vector2


func _physics_process(delta):
	look_at(get_global_mouse_position())
	# movement
	direction = Vector2(Input.get_axis('left', 'right'), Input.get_axis('up', 'down'))
	velocity = velocity.move_toward(direction.normalized() * speed, accel * delta)

	# dashing and dash buffering
	if Input.is_action_just_pressed('dash'):
		dash_buffer.start()

	if not dash_buffer.is_stopped() and dash_cd.is_stopped():
		dash()

	move_and_slide()


func dash():
	velocity = (Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees)).normalized()) * dash_speed
	dash_cd.start()
