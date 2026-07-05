extends Node2D

var move_speed = 50.0


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	#var dir = global_position.direction_to(get_parent().player.global_position)
	var dir = Vector2.LEFT
	global_position += dir * move_speed * delta


func _on_hurtbox_hit() -> void:
	$HitFX.play("flash")
	
	get_parent().play_sfx('Hit')


func _on_hurtbox_zero() -> void:
	var e = load("res://scenes/minigames/firewalls_and_viruses/actors/objs/explosion.tscn").instantiate()
	e.global_position = global_position
	get_parent().get_parent().add_child(e)
	
	get_parent().play_sfx('Explosion')
	
	queue_free()
