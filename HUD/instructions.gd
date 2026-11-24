extends CanvasLayer

signal accept_instructions()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_start_button_pressed() -> void:
	accept_instructions.emit()
