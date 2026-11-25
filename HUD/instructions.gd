extends CanvasLayer

signal accept_instructions()
@onready var select_player: AudioStreamPlayer = $SelectPlayer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_start_button_pressed() -> void:
	select_player.play()
	await select_player.finished
	accept_instructions.emit()
