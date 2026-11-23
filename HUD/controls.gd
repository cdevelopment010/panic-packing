extends CanvasLayer

signal hide_controls

func _input(event): 
	if visible: 
		if event.is_action_pressed("ui_cancel"): 
			hide_controls.emit()
