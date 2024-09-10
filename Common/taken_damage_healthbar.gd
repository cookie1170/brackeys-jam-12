extends ProgressBar

@onready var player : Player = get_tree().get_first_node_in_group('Player')

var final_value : float = 100


func _process(delta):
	value = lerpf(value, final_value, 5 * delta)


func _on_taken_damage_timer_timeout():
	final_value = player.health
