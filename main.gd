extends Node

@export var levels : Array[PackedScene] = []
var level_index = 0
var mouse_motion

func _input(event: InputEvent) -> void: 
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_motion = -event.relative * 0.001 # 0.001 can be thought of as sensistivity. Negative so the camera moves in the same way. 
	if event.is_action_pressed("ui_cancel"): 
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if (event is InputEventMouseButton 
		and event.button_index == MouseButton.MOUSE_BUTTON_LEFT 
		and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func start_game(): 
	get_tree().change_scene_to_packed(levels[level_index])
	


func _on_hud_start_game() -> void:
	start_game()


func selected_level(): 
	# Idea is the user would select a room before starting. 
	pass
