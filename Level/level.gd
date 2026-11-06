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
