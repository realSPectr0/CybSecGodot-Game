extends Control


var stage_idx = 0:
	set(value):
		$Control.get_child(stage_idx).hide()
		
		stage_idx = value
		$Control.get_child(stage_idx).show()

var current_points_total = 0


func _ready() -> void:
	for i in $Control.get_children():
		i.stage_finished.connect(_on_stage_finished)


func _physics_process(delta: float) -> void:
	$CanvasLayer/Points.text = 'Points: %d' % current_points_total


func _on_stage_finished(points) -> void:
	current_points_total += points
	stage_idx += 1
