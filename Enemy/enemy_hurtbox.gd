extends Area2D
class_name EnemyHurtbox


func _init():
	collision_layer = 0
	collision_mask = 8


func _physics_process(_delta):
	for area in get_overlapping_areas():
		if area is PlayerHitbox:
			owner.get_hit(area.damage, area.global_position, area.kb_amt, area.stun_amt)
