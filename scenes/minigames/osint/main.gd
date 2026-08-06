extends Control


var stage_idx = 0
var current_points_total = 0


func _ready() -> void:
	for i in $Control.get_children():
		i.stage_finished.connect(_on_stage_finished)


func _physics_process(delta: float) -> void:
	$CanvasLayer/Points.text = '%d' % current_points_total


func _on_stage_finished(points) -> void:
	current_points_total += points
	stage_idx += 1
