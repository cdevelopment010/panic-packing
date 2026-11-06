extends Control


var level_time : int = 60

func _ready() -> void: 
	level_time = 60
	update_timer_text()


func update_timer_text(): 
	var minutes = floor(level_time / 60)
	var seconds = floor(level_time % 60)
	$Label.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)


func _on_game_timer_timeout() -> void:
	if level_time <= 0: 
		print("Game Over")
	else: 
		level_time -= 1
		update_timer_text()
