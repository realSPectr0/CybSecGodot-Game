extends Node2D


var people_sprite_frames = [
	load("res://reso/chars_sprite_frames/char_1.tres"),
	load("res://reso/chars_sprite_frames/char_2.tres"),
	load("res://reso/chars_sprite_frames/char_3.tres"),
	load("res://reso/chars_sprite_frames/char_4.tres"),
	load("res://reso/chars_sprite_frames/char_5.tres"),
]


var spawn_time = 2


func _ready() -> void:
	$SpawnTimer.start(spawn_time)


func spawn_person():
	var random_spawn_point = Vector2(randf_range($SpawnPointLeft.global_position.x, $SpawnPointRight.global_position.x), $SpawnPointLeft.global_position.y)
	
	var e = load('res://scenes/minigames/deepfakes/actors/person.tscn').instantiate()
	e.global_position = random_spawn_point
	e.sf = people_sprite_frames.pick_random()
	$PersonsContainer.add_child(e)


func _on_spawn_timer_timeout() -> void:
	spawn_person()
	
	$SpawnTimer.start(spawn_time)
