extends Node2D

var player_bullet_pool = []


func _ready() -> void:
	var b = load('res://scenes/minigames/firewalls_and_viruses/actors/objs/PlayerBullet.tscn')
	for i in 200:
		var e = b.instantiate()
		player_bullet_pool.append(e)


func get_active_bullet():
	for i in player_bullet_pool:
		if i.is_active == false:
			return i
