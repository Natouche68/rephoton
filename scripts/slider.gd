extends Control

signal value_changed(value: float)

@export var min_value: int = 0
@export var max_value: int = 1
@export var start_value: int = 0

func _ready() -> void:
	$ProgressBar.min_value = min_value
	$ProgressBar.max_value = max_value
	$ProgressBar.value = start_value

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var value = event.position.x / get_global_rect().size.x
		value = value * (max_value - min_value) + min_value
		
		if value < min_value:
			value = min_value
		elif value > max_value:
			value = max_value
		
		$ProgressBar.value = value
		value_changed.emit(value)
