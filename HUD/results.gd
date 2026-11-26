extends Control


var current_level : Node
var packing_list : Dictionary= {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	packing_list = {}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func level_results(time):
	$Title.text = ""
	$Title/MissingItems.text = ""
	
	var missing_items: Array = []
	var results = ""
	if time <= 0:
		results = "You missed your taxi!"
	else: 
		results = "You caught the taxi!"
		
		for item in packing_list:
			if packing_list[item]["instances"].size() < packing_list[item]["required"]:
				missing_items.append(item)
			
	
	$Title.text = results
	if missing_items.size(): 
		var items = ""
		for item in missing_items: 
			items+= item + ", "
		items = items.left(-2)
		print(items)
		$Title/MissingItems.text = "... But you missed the following items " + items
	else: 
		$Title/MissingItems.text = "And packed everything you needed!"
	
		
	


func _on_restart_button_pressed() -> void:
	#get_tree().change_scene_to_node(current_level)
	print("Restart")
	get_tree().reload_current_scene()
	#pass


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://bkjn52pjswso4")
