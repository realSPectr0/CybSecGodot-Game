extends AnimatedSprite2D

var map_ref
var end_point

var already_questioned = false


func _physics_process(delta: float) -> void:
	if already_questioned:
		return
	
	if global_position.distance_to(end_point) < 6.0:
		map_ref.show_question()
		stop()
		
		already_questioned = true
		
		frame = 0
		animation = 'run_down'
	else:
		global_position.x += 75.0 * delta
