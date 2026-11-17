extends Control

@onready var checklist: Control = $"."
@onready var v_box_container: VBoxContainer = $MarginContainer/CenterContainer/VBoxContainer

var packing_manager : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass	

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("checklist"):
		toggle_checklist()	
	
	
func show_checklist(): 
	generate_checklist()
	checklist.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	
func hide_checklist(): 
	checklist.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	
func toggle_checklist(): 
	print(checklist.visible)
	if checklist.visible: 
		hide_checklist()
	else: 
		show_checklist()
	
func generate_checklist():
	for child in v_box_container.get_children(): 
		child.queue_free()
	for item in packing_manager.packing_list:
		
		var hbox = HBoxContainer.new()
		var item_label = Label.new()
		item_label.text = str(item)
		var item_amount = Label.new()
		item_amount.text = str(packing_manager.packing_list[str(item)]["instances"].size())
		var item_required = Label.new()
		item_required.text = str(packing_manager.packing_list[str(item)]["required"])
		hbox.add_child(item_label)
		hbox.add_child(item_amount)
		hbox.add_child(item_required)
		v_box_container.add_child(hbox)
		
func update_checklist(): 
	pass
