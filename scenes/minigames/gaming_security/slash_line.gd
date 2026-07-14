extends Line2D


var line_points = []


func _physics_process(delta: float) -> void:
	if line_points.size() < 10:
		line_points.append(get_global_mouse_position())
	else:
		line_points.insert(0, get_global_mouse_position())
		line_points.pop_back()
	
	points = line_points
