extends Control

@onready var checklist: Control = $"."
@onready var v_box_container: VBoxContainer = $MarginContainer/CenterContainer/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("checklist"): 
		if checklist.visible: 
			hide_checklist()
		else: 
			show_checklist()
	
	
func show_checklist(): 
	print("checklist")
	checklist.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	
func hide_checklist(): 
	checklist.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	
func generate_checklist(items):
	print(items)
	for i in 10: 
		var hbox = HBoxContainer.new()
		var item_label = Label.new()
		item_label.text = "Item_"+str(i)
		var item_amount = Label.new()
		item_amount.text= str(i)+ " / 10"
		hbox.add_child(item_label)
		hbox.add_child(item_amount)
		v_box_container.add_child(hbox)
		
		
func update_checklist(): 
	pass
