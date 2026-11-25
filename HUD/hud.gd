extends CanvasLayer

signal start_game()
signal show_controls()

@onready var select_player: AudioStreamPlayer = $SelectPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	select_player.play()
	await select_player.finished
	start_game.emit()


func _show_controls(): 
	select_player.play()
	await select_player.finished
	show_controls.emit()

func quit_game(): 
	select_player.play()
	await select_player.finished
	get_tree().quit()
