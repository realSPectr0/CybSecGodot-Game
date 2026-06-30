extends Node2D

var move_speed = 50.0


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var dir = global_position.direction_to(get_parent().player.global_position)
	global_position += dir * move_speed * delta


func _on_hurtbox_hit() -> void:
	$HitFX.play("flash")


func _on_hurtbox_zero() -> void:
	pass # Replace with function body.
