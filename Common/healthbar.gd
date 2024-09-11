extends ProgressBar

@onready var player : Player = get_tree().get_first_node_in_group('Player')
@onready var taken_damage_timer = $TakenDamageTimer


func _process(delta):
	value = lerpf(value, player.health, 2.5 * delta)
	max_value = player.health


func _on_value_changed(_changed_value):
	taken_damage_timer.start()
