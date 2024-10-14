extends Control


var warm_color: Color = Color(1, 1, 1)
var brightness: float = 1
var contrast: float = 0
var saturation: float = 1
var vignette: float = 0


func _on_color_adjust_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var value_x = event.position.x / %ColorAdjust.get_rect().size.x * 2 - 1
		var value_y = event.position.y / %ColorAdjust.get_rect().size.y * 2 - 1
		if value_x < -1:
			value_x = -1
		elif value_x > 1:
			value_x = 1
		if value_y < -1:
			value_y = -1
		elif value_y > 1:
			value_y = 1
		%ColorAdjust/Pointer.position = Vector2(value_x + 1, value_y + 1) * 64 - Vector2(8, 8)
		
		if value_x > 0:
			warm_color = Color(1, 1 - value_x / 5.0, 1 - value_x / 2.0)
		elif value_x < 0:
			value_x *= -1
			warm_color = Color(1 - value_x / 3.0, 1 - value_x / 6.0, 1)
		
		saturation = -value_y + 1
		calculate_colors()

func _on_brightness_slider_value_changed(value: float) -> void:
	brightness = value / 2 + 0.5
	calculate_colors()

func _on_contrast_slider_value_changed(value: float) -> void:
	contrast = value
	calculate_colors()

func _on_vignette_slider_value_changed(value: float) -> void:
	vignette = value
	calculate_colors()

func calculate_colors():
	%Image.material.set_shader_parameter("modulate", warm_color * brightness)
	%Image.material.set_shader_parameter("saturation", saturation)
	%Image.material.set_shader_parameter("contrast", contrast)
	%Image.material.set_shader_parameter("vignette", vignette)
