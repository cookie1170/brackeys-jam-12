extends CharacterBody2D
class_name Player


@export var speed : float
@export var accel_time : float
@export var dash_speed : float
@export var health  : int

@onready var dash_cd : Timer = $DashCooldown
@onready var dash_buffer : Timer = $DashBuffer
@onready var dash_timer : Timer = $DashTimer
@onready var shoot_cd : Timer = $ShootCooldown
@onready var i_frames : Timer = $iFrameTimer
@onready var dash_hitbox : CollisionShape2D = $DashHitbox/CollisionShape2D
@onready var hurt_particles : GPUParticles2D = $HurtParticles
@onready var shoot_point : Marker2D = $ShootPoint
@onready var accel : float = speed / accel_time

var direction : Vector2
var shoot_damage : int = 20
var dash_damage : int = 40
var bullet_scene : PackedScene = preload("res://Projectiles/Player/bullet.tscn")


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
	emit_hurt_particles(0.2, pos)
	health -= damage
	velocity = (Vector2.LEFT.rotated(rad_to_deg(get_angle_to(pos))).normalized()) * kb_amt
	i_frames.start(0.5)
	flash_white(0.3)
	if health <= 0:
		die()
	print('player health ' + str(health))


func flash_white(time):
	material.set_shader_parameter('flash', true)
	await get_tree().create_timer(time).timeout
	material.set_shader_parameter('flash', false)


func emit_hurt_particles(delay, pos):
	await get_tree().create_timer(delay).timeout
	hurt_particles.global_position = global_position	
	hurt_particles.look_at(pos)
	hurt_particles.restart()


func die():
	#placeholder
	health = 100
