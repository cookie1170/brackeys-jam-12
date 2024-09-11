extends CanvasLayer

@onready var speed_panel = $HBoxContainer/SpeedPanel
@onready var damage_panel = $HBoxContainer/DamagePanel
@onready var health_panel = $HBoxContainer/HealthPanel
@onready var buttons = [$HBoxContainer/SpeedPanel/SpeedButton, $HBoxContainer/DamagePanel/DamageButton, $HBoxContainer/HealthPanel/HealthButton]
@onready var animation_player = $AnimationPlayer


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		toggle()


func toggle():
	if speed_panel.modulate == Color.html('ffffff00')\
	 and damage_panel.modulate == Color.html('ffffff00')\
	 and health_panel.modulate == Color.html('ffffff00'):
		for button in buttons:
			button.disabled = true
		animation_player.play('fade')
	else:
		for button in buttons:
			button.disabled = false
		animation_player.play_backwards('fade')
