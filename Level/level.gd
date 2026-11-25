extends Node3D


var items_definitions: Dictionary = {
	"laptop": {
		"always_required": false,
		"min_required": 1, 
		"max_required": 1
	}, 
	"passport": {
		"always_required": true,
		"min_required": 1, 
		"max_required": 1
	}, 
	"book": {
		"always_required": false,
		"min_required": 0, 
		"max_required": 1
	}, 
	"critter": {
		"always_required": false,
		"min_required": 0, 
		"max_required": 1
	}, 
	"dino": {
		"always_required": false,
		"min_required": 0, 
		"max_required": 1
	}, 
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PackingManager.items_definitions = items_definitions
	$PackingManager.generate_packing_list()
	$Checklist.packing_manager = $PackingManager
	$Results.current_level = self
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = true


func start_level(): 
	$Instructions.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
			

func _on_player_drop_item(object: RigidBody3D, force: float = 10.0) -> void:
	object.set_collision_layer_value(2, true)
	var direction = -$Player.camera_pivot.global_transform.basis.z
	object.apply_central_impulse((direction * force) + Vector3(0.0,1.0,0.0))


func _on_suitcase_item_packed(item: Variant) -> void:
	$PackingManager.pack_item(item)


func _on_hud_game_over() -> void:
	game_over()


func _on_door_leave_game() -> void:
	game_over()
	
	
func game_over(): 
	#get_tree().change_scene_to_file("res://main.tscn")
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Results.show()
	
func restart():
	get_tree().reload_current_scene()


func _on_checklist_checklist_toggle(checklist_open: Variant) -> void:
	$Player.checklist_open = checklist_open
