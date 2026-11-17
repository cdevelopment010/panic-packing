extends Control


var current_level : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	#get_tree().change_scene_to_node(current_level)
	print("Restart")
	get_tree().reload_current_scene()
	#pass


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://bkjn52pjswso4")
