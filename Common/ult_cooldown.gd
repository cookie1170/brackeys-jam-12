extends ProgressBar

@onready var timer : Timer = get_tree().get_first_node_in_group('Player').get_node('UltCooldown')


func _process(_delta):
	value = timer.time_left
