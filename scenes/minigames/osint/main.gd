extends Control


var stage_idx = 0
var current_points_total = 0


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	$CanvasLayer/Points.text = '%d' % current_points_total
