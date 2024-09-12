extends CharacterBody2D
class_name Enemy


@export var speed : float
@export var accel_time : float
@export var health : int

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var hurt_particles : GPUParticles2D = $HurtParticles
@onready var nav_updater : Timer = $NavUpdater
@onready var stun_timer : Timer = $StunTimer
@onready var i_frames : Timer = $iFrameTimer
@onready var sprite : Sprite2D = $Sprite
@onready var player : Player = get_tree().get_first_node_in_group('Player')

@onready var accel : float = speed / accel_time

var direction : Vector2


func _physics_process(delta):
	look_at(nav_agent.get_next_path_position())
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity.move_toward(direction * speed, accel * delta)

	if not stun_timer.is_stopped():
		velocity = Vector2.ZERO
	
	move_and_slide()


func _on_nav_update():
	nav_agent.set_target_position(player.position)


func get_hit(damage, pos, kb_amt, stun_amt):
	if not i_frames.is_stopped():
		return
	hurt_particles.restart()
	health -= damage
	knockback(0.05, kb_amt, pos)
	i_frames.start(0.4)
	flash_white(0.3)
	stun_timer.start(stun_amt)
	if health <= 0:
		die()
	print('enemy health ' + str(health))


func flash_white(time):
	material.set_shader_parameter('flash', true)
	await get_tree().create_timer(time).timeout
	material.set_shader_parameter('flash', false)


func knockback(delay, amt, pos):
	await get_tree().create_timer(delay).timeout
	velocity = (Vector2.LEFT.rotated(get_angle_to(pos) + rotation).normalized()) * amt


func die():
	sprite.hide()
	hurt_particles.amount = 100
	hurt_particles.explosiveness = 0.8
	hurt_particles.emitting = true
	stun_timer.start(0.5)
	await stun_timer.timeout
	queue_free()
