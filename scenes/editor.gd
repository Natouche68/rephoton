extends Control


var warm_color: Color = Color(1, 1, 1)
var tint_color: Color = Color(1, 1, 1)


func _on_warm_slider_value_changed(value: float) -> void:
	if value > 0:
		warm_color = Color(1.1, 1 - value / 5, 1 - value / 2)
	elif value < 0:
		value *= -1
		warm_color = Color(1 - value / 3, 1 - value / 6, 1.1)
	
	calculate_modulate_color()

func _on_tint_slider_value_changed(value: float) -> void:
	if value > 0:
		tint_color = Color(1 - value / 10, 1 - value / 4, 1.1)
	elif value < 0:
		value *= -1
		tint_color = Color(1 - value / 4, 1.1, 1 - value / 4)
	
	calculate_modulate_color()

func calculate_modulate_color():
	$Image.modulate = (warm_color + tint_color) / 2
