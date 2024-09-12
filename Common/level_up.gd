extends CanvasLayer

@onready var speed_panel = $HBoxContainer/SpeedPanel
@onready var damage_panel = $HBoxContainer/DamagePanel
@onready var health_panel = $HBoxContainer/HealthPanel
@onready var buttons = [$HBoxContainer/SpeedPanel/SpeedButton, $HBoxContainer/DamagePanel/DamageButton, $HBoxContainer/HealthPanel/HealthButton]
@onready var animation_player = $AnimationPlayer


func toggle():
	if speed_panel.modulate == Color.html('ffffff00')\
	 and damage_panel.modulate == Color.html('ffffff00')\
	 and health_panel.modulate == Color.html('ffffff00'):
		for button in buttons:
			button.disabled = false
			get_tree().paused = true
		animation_player.play('fade')
	else:
		for button in buttons:
			button.disabled = true
			get_tree().paused = false
		animation_player.play_backwards('fade')
