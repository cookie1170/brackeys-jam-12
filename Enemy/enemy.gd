extends CharacterBody2D
class_name Enemy


@export var speed : float
@export var accel_time : float
@export var health : int

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var nav_updater : Timer = $NavUpdater
@onready var player : Player = get_tree().get_first_node_in_group('Player')

@onready var accel : float = speed / accel_time

var direction : Vector2


func _physics_process(delta):
	look_at(nav_agent.get_next_path_position())
	direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.move_toward(direction * speed, accel * delta)
	
	move_and_slide()


func _on_nav_update():
	nav_agent.set_target_position(player.position)
