extends Sprite2D



func _on_timer_timeout():
	var enemy = preload("res://Enemy/enemy.tscn").instantiate()
	add_sibling(enemy)
