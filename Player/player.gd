extends CharacterBody3D

@onready var camera_pivot: Node3D = $CameraPivot
@onready var label: Label = $CanvasLayer/BoxContainer/Label

signal drop_item(object)

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouse_motion := Vector2.ZERO
var holding_item: bool = false
var current_object

func _ready() -> void: 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _physics_process(delta: float) -> void:
	handle_camera_rotation()	
	
	label.hide()
	if %SeeCast.is_colliding():
		var target: StaticBody3D = %SeeCast.get_collider()
		if target != null and target.is_in_group("items"):
			label.show()
			if Input.is_action_just_pressed("interact") and not holding_item:
				target.reparent(self)
				current_object = target
				target.set_collision_layer_value(1,false)
				holding_item = true
				#target.interact()
	if Input.is_action_just_pressed("interact") and holding_item and current_object != null:
		print("drop item")
		drop_item.emit(current_object)
		
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
