extends Node

@export var levels : Array[PackedScene] = []
var level_index = 0
var mouse_motion

func _ready() -> void:
	get_tree().paused = false

func start_game(): 
	get_tree().change_scene_to_packed(levels[level_index])

func _on_hud_start_game() -> void:
	start_game()

func selected_level(): 
	# Idea is the user would select a room before starting. 
	pass


func _on_hud_show_controls() -> void:
	print("show controls")
	$HUD.hide()
	$Controls.show()


func _on_controls_hide_controls() -> void:
	$HUD.show()
	$Controls.hide()
