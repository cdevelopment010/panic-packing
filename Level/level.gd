extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_player_drop_item(object: RigidBody3D, force: float = 10.0) -> void:
	object.set_collision_layer_value(1, true)
	object.freeze = false
	object.reparent(self)
	var direction = -$Player.camera_pivot.global_transform.basis.z
	object.apply_central_impulse(direction * force)


func _on_suitcase_item_packed(item: Variant) -> void:
	$PackingManager.pack_item(item)


func _on_hud_game_over() -> void:
	game_over()


func _on_door_leave_game() -> void:
	game_over()
	
	
func game_over(): 
	#get_tree().change_scene_to_file("res://main.tscn")
	get_tree().paused = true
	# Some sort of score pop-up
	
func restart():
	get_tree().reload_current_scene()
