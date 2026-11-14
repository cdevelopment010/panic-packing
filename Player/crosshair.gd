extends Control

var charge_time : float = 0.0
var max_charge_time: float = 2.0
var pulse_time := 0.0

func _process(delta: float) -> void:
	if charge_time / max_charge_time >= 1.0:
		pulse_time += delta
		queue_redraw()
	else: 
		pulse_time = 0.0

func _draw() -> void:
	draw_circle(Vector2.ZERO,2.0, Color.WHITE, true)
	var percent = clampf(charge_time / max_charge_time, 0.0, 1.0)
	var end_angle = lerpf(0.0,360.0, percent)
	var arc_color = Color.GREEN.lerp(Color.RED, percent)
	
	#pulse
	var radius = 10.0
	if percent >= 1.0:
		var pulse = (sin(pulse_time * 8.0) + 1.0) / 2.0
		radius += pulse * 2.0
	
	draw_arc(
		Vector2.ZERO,
		radius,  
		deg_to_rad(-90.0), 
		deg_to_rad(-90+end_angle), 
		32, 
		arc_color)


func set_charge(value: float, max_value: float) -> void: 
	charge_time = value
	max_charge_time = max_value
	queue_redraw()
