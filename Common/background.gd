extends ColorRect

func _process(delta):
	material.set_shader_parameter('bgcolor', color)
