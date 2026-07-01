extends Node2D

var player_bullet_pool = []


@onready var player = $Player


func _ready() -> void:
	var b = load('res://scenes/minigames/firewalls_and_viruses/actors/objs/PlayerBullet.tscn')
	for i in 200:
		var e = b.instantiate()
		player_bullet_pool.append(e)
	
	tree_exiting.connect(func():
		var player = get_tree().get_nodes_in_group("Player")[0]
		player.freeze = false
	)


func get_active_bullet():
	for i in player_bullet_pool:
		if i.is_active == false:
			return i


func spawn_enemy():
	var e = load('res://scenes/minigames/firewalls_and_viruses/actors/entities/enemies.tscn').instantiate()
	e.global_position = $SpawnPoints.get_children().pick_random().global_position
	
	add_child(e)


func _on_enemy_spawn_timer_timeout() -> void:
	spawn_enemy()
