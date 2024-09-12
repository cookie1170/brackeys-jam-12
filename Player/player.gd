extends CharacterBody2D
class_name Player


@onready var dash_cd : Timer = $DashCooldown
@onready var dash_buffer : Timer = $DashBuffer
@onready var dash_timer : Timer = $DashTimer
@onready var shoot_cd : Timer = $ShootCooldown
@onready var i_frames : Timer = $iFrameTimer
@onready var heal_timer : Timer = $HealTimer
@onready var dash_hitbox : CollisionShape2D = $DashHitbox/CollisionShape2D
@onready var hurt_particles : GPUParticles2D = $HurtParticles
@onready var dash_particles : GPUParticles2D = $DashParticles
@onready var shoot_point : Marker2D = $ShootPoint

# variables
var direction : Vector2
var xp : int = 0
var required_xp : int = 50
var shoot_damage : int = 20
var attack_speed : float = 0.35
var dash_damage : int = 40
var health : int = 100
var max_health : int = 100
var move_speed : int = 360
var accel_time : float = 0.1
var accel : int = 3600
var dash_speed : int = 1600
var bullet_scene : PackedScene = preload("res://Projectiles/Player/bullet.tscn")
var damage_items : Array = []
var health_items : Array = []
var move_speed_items : Array = []


func _ready():
	Signals.enemy_killed.connect(_on_enemy_killed)


func _process(_delta):
	look_at(get_global_mouse_position())


func _physics_process(delta):
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

	# levelling up duh
	if xp >= required_xp:
		level_up()

	move_and_slide()


func dash():
	velocity = (Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees)).normalized()) * dash_speed
	dash_cd.start()
	dash_hitbox.get_parent().damage = dash_damage
	dash_timer.start()
	dash_particles.emitting = true
	i_frames.start(0.3)


func shoot():
	# instantiates the bullet scene
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
	heal_timer.start()
	health -= damage
	velocity = (Vector2.LEFT.rotated(get_angle_to(pos) + rotation).normalized()) * kb_amt
	slowdown(0.025, 0.35)
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


func update_stats():
	# reset stats
	shoot_damage = 20
	dash_damage = 40
	max_health = 100
	move_speed = 360
	attack_speed = 0.35

	# adds stats for each item
	for i in len(damage_items):
		shoot_damage += damage_items[i]
		dash_damage += damage_items[i] * 1.5
	for i in len(move_speed_items):	
		move_speed += move_speed_items[i] * 2
		if attack_speed > 0.1: attack_speed -= move_speed_items[i] * 0.00125
	for i in len(health_items):
		health += health_items[i]

	accel = move_speed / accel_time
	health = max_health


func _on_enemy_killed():
	xp += 10
	print(xp)


func level_up():
	xp = 0
	required_xp *= 1.1
	LevelUp.toggle()


func _on_heal_timeout():
	# healing
	health = max_health
	print('healed')
