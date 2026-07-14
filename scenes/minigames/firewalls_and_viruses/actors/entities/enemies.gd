extends Node2D

var move_speed = 50.0


func _ready() -> void:
	move_speed = get_parent().player.virus_movement
	
	$HPBar.max_value = $Hurtbox.hp


func _physics_process(delta: float) -> void:
	#var dir = global_position.direction_to(get_parent().player.global_position)
	var dir = Vector2.LEFT
	global_position += dir * move_speed * delta
	
	$HPBar.value = $Hurtbox.hp


func set_hp(new_hp):
	$Hurtbox.hp = new_hp


func _on_hurtbox_hit() -> void:
	$HitFX.play("flash")
	
	get_parent().play_sfx('Hit')
	
	var df = load('res://scenes/minigames/firewalls_and_viruses/actors/objs/DamageFloater.tscn').instantiate()
	df.global_position = global_position
	df.get_node('Label').text = '%d'%  get_parent().player.damage
	get_parent().add_child(df)


func _on_hurtbox_zero() -> void:
	var e = load("res://scenes/minigames/firewalls_and_viruses/actors/objs/explosion.tscn").instantiate()
	e.global_position = global_position
	get_parent().add_child(e)
	
	get_parent().player.credits += 7
	
	get_parent().play_sfx('Explosion')
	
	queue_free()
