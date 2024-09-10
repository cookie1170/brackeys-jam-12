extends Area2D
class_name EnemyHitbox


@export var damage : int = 20
@export var kb_amt : float = 1000

func _init():
	collision_layer = 16
	collision_mask = 0
