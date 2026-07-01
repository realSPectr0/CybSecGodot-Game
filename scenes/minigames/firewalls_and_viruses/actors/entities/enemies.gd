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


func _on_hurtbox_zero() -> void:
	queue_free()
