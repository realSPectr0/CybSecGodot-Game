extends Node2D


var move_speed = 75.0
var dir: Vector2

var hp = 4

var can_move = true


func _ready() -> void:
	if dir == Vector2.RIGHT:
		$AnimatedSprite2D.play('run_right')
	elif dir == Vector2.LEFT:
		$AnimatedSprite2D.play('run_left')
	elif dir == Vector2.UP:
		$AnimatedSprite2D.play('run_up')
	elif dir == Vector2.DOWN:
		$AnimatedSprite2D.play('run_down')
	
	$HPBar.max_value = hp


func _physics_process(delta: float) -> void:
	if can_move == false:
		return
	
	global_position += dir * move_speed * delta
	
	$HPBar.value = hp


func _on_area_2d_mouse_entered() -> void:
	hp -= 1
	
	$HitFX.play("flash")
	
	if hp <= 0:
		queue_free()
