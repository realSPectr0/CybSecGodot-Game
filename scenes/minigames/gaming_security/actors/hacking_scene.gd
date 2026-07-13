extends Control


var can_popup = true


func _ready() -> void:
	$Main/ProgressBar.max_value = $Timer.wait_time
	
	$DistractionPopupCooldown.start(randf_range(3, 5))


func _physics_process(delta: float) -> void:
	if $Popups.get_child_count() > 0:
		$Timer.paused = true
		return
	else:
		$Timer.paused = false
	
	$Main/ProgressBar.value = $Timer.wait_time - $Timer.time_left
	
	$Code.visible_ratio += delta / $Timer.wait_time


func popup_distraction():
	var random_pos = Vector2(randf_range(0, 600), randf_range(0, 300))
	var e = load('res://scenes/minigames/gaming_security/actors/distraction_window.tscn').instantiate()
	e.position = random_pos
	
	$Popups.add_child(e)


func _on_timer_timeout() -> void:
	pass # Replace with function body.


func _on_end_timer_timeout() -> void:
	pass # Replace with function body.


func _on_distraction_popup_timer_timeout() -> void:
	if can_popup:
		popup_distraction()
	
	$DistractionPopupTimer.start(randf_range(.1, 2))


func _on_distraction_popup_cooldown_timeout() -> void:
	can_popup = !can_popup
	
	$DistractionPopupCooldown.start(randf_range(3,5))
