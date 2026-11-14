extends Area3D

signal leave_game

@onready var label: Label = $Control/CenterContainer/Label

var is_player_entered := false

func _input(event: InputEvent) -> void:
	if is_player_entered: 
		if event.is_action_pressed("interact"): 
			print("GAME OVER")
			leave_game.emit()

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		label.show()
		is_player_entered = true


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		label.hide()
		is_player_entered = false
