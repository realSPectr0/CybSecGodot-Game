extends CharacterBody2D

var move_speed = 150.0
var vel: Vector2

var can_move = true
var can_shoot = true


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
	
	if can_move:
		$Container.look_at(get_global_mouse_position())
		
		vel.x = Input.get_axis('ui_left', 'ui_right') * move_speed
		vel.y = Input.get_axis('ui_up', 'ui_down') * move_speed
		
		velocity = vel
		
		move_and_slide()


func shoot():
	var b = get_parent().get_active_bullet()
	
	can_shoot = false
	$ShootCooldown.start()
	
	if b:
		b.global_position = global_position
		b.look_at(get_global_mouse_position())
		b.dir = global_position.direction_to(get_global_mouse_position())
		b.is_active = true
		
		get_parent().add_child(b)


func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
