extends Area2D
class_name PlayerHitbox


@export var damage : int

func _init():
	collision_layer = 8
	collision_mask = 0
