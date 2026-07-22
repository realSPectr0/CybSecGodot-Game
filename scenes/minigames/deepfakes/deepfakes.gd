extends Node2D


var people_sprite_frames = [
	load("res://reso/chars_sprite_frames/char_1.tres"),
	load("res://reso/chars_sprite_frames/char_2.tres"),
	load("res://reso/chars_sprite_frames/char_3.tres"),
	load("res://reso/chars_sprite_frames/char_4.tres"),
	load("res://reso/chars_sprite_frames/char_5.tres"),
]

var player_bullet_pool = []


var spawn_time = 2


func _ready() -> void:
	$SpawnTimer.start(spawn_time)
	
	var b = load('res://scenes/minigames/firewalls_and_viruses/actors/objs/PlayerBullet.tscn')
	for i in 200:
		var e = b.instantiate()
		player_bullet_pool.append(e)
	
	$UI/GameTimeBar.max_value = $GameTimer.wait_time


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
		shoot()


func _physics_process(delta: float) -> void:
	$UI/GameTimeBar.value = $GameTimer.time_left


func get_active_bullet():
	for i in player_bullet_pool:
		if i.is_active == false:
			return i


func shoot():
	var b = get_active_bullet()
	
	if b:
		b.is_active = true
		b.dir = $Cannon.global_position.direction_to(get_global_mouse_position())
		b.global_position = $Cannon.global_position
		b.look_at(get_global_mouse_position())
		
		add_child(b)
		$Laser.play()


func game_over(message = ''):
	get_tree().paused = true
	
	$UI/GameOverPanel/Label.text = message
	$UI/GameOverPanel.show()


func spawn_person():
	var random_spawn_point = Vector2(randf_range($SpawnPointLeft.global_position.x, $SpawnPointRight.global_position.x), $SpawnPointLeft.global_position.y)
	
	var e = load('res://scenes/minigames/deepfakes/actors/person.tscn').instantiate()
	e.global_position = random_spawn_point
	e.sf = people_sprite_frames.pick_random()
	e.death.connect(on_person_death)
	e.hit.connect(on_person_hit)
	e.is_fake = true if randf() < 0.5 else false
	
	$PersonsContainer.add_child(e)


func _on_spawn_timer_timeout() -> void:
	spawn_person()
	
	$SpawnTimer.start(spawn_time)


func _on_end_area_entered(area: Area2D) -> void:
	if area.get_parent().is_fake:
		game_over('GAME OVER THE DEEPFAKES HAVE BREACHED THE OFFICE.')


func _on_quit_pressed() -> void:
	get_tree().paused = false
	GameManager.finish_minigame()
	#queue_free()


func on_person_death(ref):
	if ref.is_fake == false:
		game_over('GAME OVER YOU KILLED A REAL PERSON!')


func on_person_hit():
	$Hit.play()


func _on_game_timer_timeout() -> void:
	game_over('GAME WIN!')
