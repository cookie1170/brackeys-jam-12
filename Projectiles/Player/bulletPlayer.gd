extends RigidBody2D

var force : float = 2000
var damage : int = 20

func shoot():
	apply_central_force((Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees))) * force)
	$BulletHitbox.damage = damage


func _on_despawn():
	queue_free()
