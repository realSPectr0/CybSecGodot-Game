extends Control


var can_popup = true


func _ready() -> void:
	$Main/ProgressBar.max_value = $Timer.wait_time
	$EndBar.max_value = $EndTimer.wait_time
	
	$DistractionPopupCooldown.start(randf_range(3, 5))
	
	$Control.show()


func _physics_process(delta: float) -> void:
	$EndBar.value = $EndTimer.time_left
	
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


func game_over(is_win = false):
	if is_win:
		$GameOverControl/Panel/Prevented.show()
	else:
		$GameOverControl/Panel/Over.show()
	
	$GameOverControl.show()
	
	$Timer.stop()
	$DistractionPopupTimer.stop()
	$DistractionPopupCooldown.stop()


func _on_timer_timeout() -> void:
	game_over(true)


func _on_end_timer_timeout() -> void:
	game_over(false)


func _on_distraction_popup_timer_timeout() -> void:
	if can_popup:
		popup_distraction()
	
	$DistractionPopupTimer.start(randf_range(.1, 2))


func _on_distraction_popup_cooldown_timeout() -> void:
	can_popup = !can_popup
	
	$DistractionPopupCooldown.start(randf_range(3,5))


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$Timer.start()
	$EndTimer.start()
	$DistractionPopupTimer.start()
	
	$Control.hide()
	
	game_over(true)


func _on_close_pressed() -> void:
	get_tree().paused = false
	queue_free()
