extends ProgressBar

@onready var timer : Timer = get_tree().get_first_node_in_group('Player').get_node('DashCooldown')


func _process(delta):
	value = timer.time_left
