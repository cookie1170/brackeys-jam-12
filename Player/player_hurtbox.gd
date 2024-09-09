extends Area2D
class_name PlayerHurtbox


func _init():
	collision_layer = 0
	collision_mask = 16


func _ready():
	connect('area_entered', _on_get_hit)


func _on_get_hit(hitbox : EnemyHitbox):
	if hitbox == null:
		return


	if owner.has_method('take_damage'):
		owner.take_damage(hitbox.damage)
