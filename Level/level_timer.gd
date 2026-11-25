extends Control

signal game_over()
@export var level_time : int = 60
@onready var taxi_sound: AudioStreamPlayer = $TaxiSound

var taxi_sound_played:bool = false

func _ready() -> void: 
	update_timer_text()


func update_timer_text(): 
	var minutes = floor(level_time / 60.0)
	var seconds = floor(level_time % 60)
	$Label.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)


func _on_game_timer_timeout() -> void:
	if level_time <= 10 and not taxi_sound_played:
		taxi_sound.play()
		taxi_sound_played = true
	if level_time <= 0: 
		print("Game Over")
		game_over.emit()
	else: 
		level_time -= 1
		update_timer_text()
