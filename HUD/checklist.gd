extends CanvasLayer

signal checklist_toggle(checklist_open)

@onready var checklist: Control = $"Control"
@onready var v_box_container: VBoxContainer = $Control/Panel/MarginContainer/VBoxContainer

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
	#get_tree().paused = true
	
func hide_checklist(): 
	checklist.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#get_tree().paused = false
	
func toggle_checklist(): 
	if checklist.visible: 
		hide_checklist()
	else: 
		show_checklist()
	checklist_toggle.emit(checklist.visible)
	
func generate_checklist():
	for child in v_box_container.get_children(): 
		child.queue_free()
	
	# title
	
	var hbox_title = HBoxContainer.new()
	var item_title = Label.new()
	item_title.text = "Checklist"
	item_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	item_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	item_title["theme_override_colors/font_color"] = Color.BLACK
	item_title["theme_override_font_sizes/font_size"] = "24px"
	hbox_title.add_child(item_title)
	v_box_container.add_child(hbox_title)
	
	# Header row
	var hbox_header = HBoxContainer.new()
	var item_label_header = generate_label()
	var item_amount_header = generate_label()
	var item_required_header = generate_label()
	
	item_label_header.text = "Item"
	item_amount_header.text = "Amount Packed"
	item_required_header.text = "Amount Required"
	hbox_header.add_child(item_label_header)
	hbox_header.add_child(item_amount_header)
	hbox_header.add_child(item_required_header)
	v_box_container.add_child(hbox_header)
	
	for item in packing_manager.packing_list:
		
		var hbox = HBoxContainer.new()
		var item_label = generate_label()
		item_label.text = str(item)
		var item_amount = generate_label()
		item_amount.text = str(packing_manager.packing_list[str(item)]["instances"].size())
		var item_required = generate_label()
		item_required.text = str(packing_manager.packing_list[str(item)]["required"])
		hbox.add_child(item_label)
		hbox.add_child(item_amount)
		hbox.add_child(item_required)
		v_box_container.add_child(hbox)
		
func update_checklist(): 
	pass


func generate_label() -> Label:
	var label = Label.new()
	label.size_flags_horizontal = Control.SIZE_EXPAND
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label["theme_override_colors/font_color"] = Color.BLACK
	return label
	
