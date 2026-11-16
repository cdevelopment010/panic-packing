extends Control

signal restart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#if get_tree().paused: 
		#self.visible = true
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#else: 
		#self.visible = false
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func show_pause(): 
	self.visible = true
	
func hide_pause(): 
	self.visible = false

func _on_button_pressed() -> void:
	get_tree().paused = false
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	restart.emit()
