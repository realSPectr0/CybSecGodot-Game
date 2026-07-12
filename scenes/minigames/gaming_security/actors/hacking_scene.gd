extends Control

func _ready() -> void:
	$Main/ProgressBar.max_value = $Timer.wait_time


func _physics_process(delta: float) -> void:
	$Main/ProgressBar.value = $Timer.wait_time - $Timer.time_left
	
	$Code.visible_ratio += delta / 20
	print($Code.visible_ratio)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
