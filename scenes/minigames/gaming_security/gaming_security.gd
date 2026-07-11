extends Node2D


var money = 0

var stage = 1
var stage_max = 5


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func _on_gui_input(event: InputEvent) -> void:
	pass


func _on_stage_timer_timeout() -> void:
	$StageTimer.start()
