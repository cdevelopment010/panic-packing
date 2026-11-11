extends Node

var items_definitions: Dictionary = {
	"laptop": {
		"always_required": false,
		"min_required": 1, 
		"max_required": 1
	}
}


enum Priority { NOT_REQUIRE, OPTIONAL, CRITICAL}
enum Status { UNPACKED, PACKED, BROKEN }

var packing_list: Dictionary = {}

func _ready() -> void:
	# 1st version - some items are to be packed
	generate_packing_list()

func generate_packing_list(): 
	for item_id in items_definitions:
		if packing_list.has(str(item_id)):
			continue
		packing_list[str(item_id)] = {}
		packing_list[str(item_id)]["priority"] = Priority.CRITICAL if items_definitions[item_id]["always_required"] else Priority.values()[randi() % Priority.size()]
		var min_required = items_definitions[item_id].get("min_required", 1)
		var max_required = items_definitions[item_id].get("max_required", 1)
		packing_list[str(item_id)]["required"] = randi_range(min_required, max_required)
		packing_list[str(item_id)]["instances"] = {}		
	print(packing_list)


func pack_item(item):
	if not packing_list.has(str(item.type)): 
		packing_list[str(item.type)] = {}
		packing_list[str(item.type)]["priority"] = Priority.NOT_REQUIRE
		packing_list[str(item.type)]["required"] = 0
		packing_list[str(item.type)]["instances"] = {}
	
	if packing_list[str(item.type)]["instances"].has(str(item.id)): 
		return
	else: 
		var instance = {}
		instance["status"] = Status.PACKED
		packing_list[str(item.type)]["instances"][str(item.id)] = instance
		print(packing_list)	
		
	update_checklist()
		
		
func update_checklist():
	pass
