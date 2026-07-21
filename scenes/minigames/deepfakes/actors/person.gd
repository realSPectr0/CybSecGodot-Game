extends Node2D

signal death(ref)


var dir : Vector2 = Vector2.DOWN
var prev_dir : Vector2 = Vector2.ZERO
var move_speed = 50.0

var is_fake = false

var sf

@onready var anim_sprite = $AnimatedSprite2D

func _ready() -> void:
	$ChangeDirTimer.start(randf_range(1, 3))
	
	if sf:
		$AnimatedSprite2D.sprite_frames = sf
	
	if is_fake:
		modulate = Color.RED


func _physics_process(delta: float) -> void:
	$Node2D.look_at(global_position + dir)
	
	if dir == Vector2.DOWN:
		$AnimatedSprite2D.play("run_down")
	elif dir == Vector2.LEFT:
		$AnimatedSprite2D.play("run_left")
	elif dir == Vector2.RIGHT:
		$AnimatedSprite2D.play("run_right")
	
	if $Node2D/RayCast2D.get_collider():
		dir = Vector2.DOWN
		$ChangeDirTimer.stop()
		$ChangeDirTimer.start(randf_range(1, 3))
	
	global_position += dir * move_speed * delta
	
	if global_position.y > 480.0:
		queue_free()


func _on_change_dir_timer_timeout() -> void:
	if prev_dir == Vector2.ZERO:
		if randf() > 0.5:
			dir = Vector2.RIGHT
		else:
			dir = Vector2.LEFT
	else:
		if prev_dir == Vector2.LEFT:
			dir = Vector2.RIGHT
		else:
			dir = Vector2.LEFT
	
	$ChangeDirTimer.start(randf_range(1, 3))


func _on_hurtbox_hit() -> void:
	$HitFX.play("flash")


func _on_hurtbox_zero() -> void:
	#if is_fake == false:
		#pass
	
	death.emit(self)
	
	queue_free()
