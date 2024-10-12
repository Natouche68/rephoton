extends Control


var warm_color: Color = Color(1, 1, 1)
var saturation: float = 1
var vignette: float = 0


func _on_warm_slider_value_changed(value: float) -> void:
	if value > 0:
		warm_color = Color(1.1, 1 - value / 5, 1 - value / 2)
	elif value < 0:
		value *= -1
		warm_color = Color(1 - value / 3, 1 - value / 6, 1.1)
	
	calculate_colors()

func _on_saturation_slider_value_changed(value: float) -> void:
	saturation = value
	
	calculate_colors()

func _on_vignette_slider_value_changed(value: float) -> void:
	vignette = value
	
	calculate_colors()

func calculate_colors():
	$Image.material.set_shader_parameter("modulate", warm_color)
	$Image.material.set_shader_parameter("saturation", saturation)
	$Image.material.set_shader_parameter("vignette", vignette)
