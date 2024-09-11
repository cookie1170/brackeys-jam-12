extends Area2D
class_name PlayerHitbox


@export var damage : int = 20
@export var kb_amt : int = 1000
@export var stun_amt : float = 0.2

func _init():
	collision_layer = 8
	collision_mask = 0
