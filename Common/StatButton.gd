extends TextureButton

@onready var player : Player = get_tree().get_first_node_in_group('Player')

@export var stat : int = 1
@export var stat_amount : int = 20


func _on_pressed():
	match stat:
		0: player.move_speed_items.append(stat_amount)
		1: player.damage_items.append(stat_amount)
		2: player.health_items.append(stat_amount)
	player.update_stats()
	owner.toggle()
