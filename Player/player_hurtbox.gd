extends Area2D
class_name PlayerHurtbox


func _init():
	collision_layer = 0
	collision_mask = 16


func _physics_process(_delta):
	for area in get_overlapping_areas():
		if area is EnemyHitbox:
			owner.get_hit(area.damage, area.global_position, area.kb_amt)
