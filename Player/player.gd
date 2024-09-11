extends CharacterBody2D
class_name Player


@onready var dash_cd : Timer = $DashCooldown
@onready var dash_buffer : Timer = $DashBuffer
@onready var dash_timer : Timer = $DashTimer
@onready var shoot_cd : Timer = $ShootCooldown
@onready var i_frames : Timer = $iFrameTimer
@onready var dash_hitbox : CollisionShape2D = $DashHitbox/CollisionShape2D
@onready var hurt_particles : GPUParticles2D = $HurtParticles
@onready var shoot_point : Marker2D = $ShootPoint
@onready var accel : float = move_speed / accel_time

var direction : Vector2
var shoot_damage : int = 20
var dash_damage : int = 40
var health  : int = 100
var move_speed : int = 360
var accel_time : int = 0.1
var dash_speed : int = 1600
var bullet_scene : PackedScene = preload("res://Projectiles/Player/bullet.tscn")
var damage_items : Array = []
var health_items : Array = []
var move_speed_items : Array = []


func _physics_process(delta):
	look_at(get_global_mouse_position())
	# movement
	direction = Vector2(Input.get_axis('left', 'right'), Input.get_axis('up', 'down'))
	velocity = velocity.move_toward(direction.normalized() * move_speed, accel * delta)

	# dashing and dash buffering
	if Input.is_action_just_pressed('dash'):
		dash_buffer.start()

	if not dash_buffer.is_stopped() and dash_cd.is_stopped():
		dash()

	dash_hitbox.disabled = dash_timer.is_stopped()

	# shooting
	if Input.is_action_just_pressed('attack') and shoot_cd.is_stopped():
		shoot()

	move_and_slide()


func dash():
	velocity = (Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees)).normalized()) * dash_speed
	dash_cd.start()
	dash_hitbox.get_parent().damage = dash_damage
	dash_timer.start()
	i_frames.start(0.3)


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.rotation = rotation
	bullet.damage = shoot_damage
	bullet.position = shoot_point.global_position
	add_sibling(bullet)
	bullet.shoot()
	shoot_cd.start()


func get_hit(damage, pos, kb_amt):
	if not i_frames.is_stopped():
		return
	hurt_particles.restart()
	health -= damage
	velocity = (Vector2.LEFT.rotated(get_angle_to(pos) + rotation).normalized()) * kb_amt
	slowdown(0.025, 0.25)
	i_frames.start(1)
	flash_white(0.3)
	if health <= 0:
		die()
	print('player health ' + str(health))


func flash_white(time):
	material.set_shader_parameter('flash', true)
	await get_tree().create_timer(time).timeout
	material.set_shader_parameter('flash', false)


func slowdown(length, amt):
	Engine.time_scale = amt
	await get_tree().create_timer(length / amt).timeout
	Engine.time_scale = 1


func die():
	#placeholder
	health = 100
