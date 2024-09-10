extends Area2D
class_name PlayerHitbox


@export var damage : int = 20
@export var kb_amt : float = 1500

func _init():
	collision_layer = 8
	collision_mask = 0
