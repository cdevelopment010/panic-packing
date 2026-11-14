extends CharacterBody3D

@onready var camera_pivot: Node3D = $CameraPivot
@onready var label: Label = $CanvasLayer/BoxContainer/Label
@onready var marker_3d: Marker3D = $CameraPivot/Marker3D

signal drop_item(object, force)

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouse_motion := Vector2.ZERO
var holding_item: bool = false
var charging_item: bool = false
var force: float = 0.0
var current_object

func _ready() -> void: 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _physics_process(delta: float) -> void:
	handle_camera_rotation()	
	
	label.hide()
	if %SeeCast.is_colliding():
		var target = %SeeCast.get_collider()
		if target != null and target is RigidBody3D and target.is_in_group("items"):
			label.show()
			
		if target != null and target is RigidBody3D and target.is_in_group("door"):
			target.show_label
	
	if Input.is_action_just_pressed("interact"): 
		if not charging_item and holding_item: 
			charging_item = true
		elif %SeeCast.is_colliding() and not holding_item: 
			
			var target = %SeeCast.get_collider()
			if target != null  and target is RigidBody3D and target.is_in_group("items"):
				charging_item = false
				force = 0.0
				target.reparent(marker_3d)
				target.freeze = true
				target.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
				current_object = target
				target.set_collision_layer_value(1,false)
				holding_item = true
	if charging_item: 
		force += delta * 10
		force = clampf(force, 0.5, 20.0)
		$CenterContainer/Crosshair.set_charge(force, 20)
	
	if Input.is_action_just_released("interact") and charging_item: 
		$CenterContainer/Crosshair.set_charge(0, 20)
		drop_item.emit(current_object, force)
		charging_item = false
		force = 0.0
		holding_item = false
		current_object = null	
	
	
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	
func _input(event: InputEvent) -> void: 
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_motion = -event.relative * 0.001 # 0.001 can be thought of as sensistivity. Negative so the camera moves in the same way. 
	if event.is_action_pressed("ui_cancel"): 
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if (event is InputEventMouseButton 
		and event.button_index == MouseButton.MOUSE_BUTTON_LEFT 
		and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func handle_camera_rotation() -> void: 
	#rotate player
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clampf(
		camera_pivot.rotation_degrees.x,
		-90,
		90
	)
	mouse_motion = Vector2.ZERO #rest otherwise camera will keep rotating. 
