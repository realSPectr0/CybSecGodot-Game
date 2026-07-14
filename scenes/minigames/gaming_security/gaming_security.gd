extends Node2D


var money = 0


func _ready() -> void:
	$UI/ProgressBar.max_value = $StageTimer.wait_time


func _physics_process(delta: float) -> void:
	$UI/ProgressBar.value = $StageTimer.time_left


func spawn_hacker():
	var random_spawn = $SpawnPoints.get_children().pick_random()
	
	var e = load('res://scenes/minigames/gaming_security/actors/hacker.tscn').instantiate()
	e.global_position = random_spawn.global_position
	
	if random_spawn == $SpawnPoints/Left:
		e.dir = Vector2.RIGHT
	elif random_spawn == $SpawnPoints/Top:
		e.dir = Vector2.DOWN
	elif random_spawn == $SpawnPoints/Bottom:
		e.dir = Vector2.UP
	elif random_spawn == $SpawnPoints/Right:
		e.dir = Vector2.LEFT
	
	$HackersContainer.add_child(e)


func _on_gui_input(event: InputEvent) -> void:
	pass


func _on_stage_timer_timeout() -> void:
	# game over
	
	
	queue_free()


func _on_hacker_spawn_timer_timeout() -> void:
	spawn_hacker()


func _on_pc_area_area_entered(area: Area2D) -> void:
	for i in $HackersContainer.get_children():
		i.queue_free()
	
	var e = load('res://scenes/minigames/gaming_security/actors/HackingScene.tscn').instantiate()
	$UI.add_child(e)
	
	get_tree().paused = true
