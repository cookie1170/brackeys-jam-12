extends ProgressBar

@onready var timer : Timer = get_tree().get_first_node_in_group('Player').get_node('DashCooldown')


func _process(delta):
	value = 1.0 - timer.time_left
