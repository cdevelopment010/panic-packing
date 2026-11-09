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
		# TODO: Turn instances into a dictionary. 
		#packing_list[str(item_id)]["instances"] = []
		print(packing_list[str(item_id)]["required"])
		# TODO: instances populating when adding an item to the suitcase
		#for i in packing_list[str(item_id)]["required"]: 
			#var instance = {}
			#instance["id"] = i
			#instance["status"] = Status.UNPACKED
			#packing_list[str(item_id)]["instances"].append(instance)
		
	print(packing_list)
