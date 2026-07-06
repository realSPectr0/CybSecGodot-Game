extends CharacterBody2D

var move_speed = 150.0
var vel: Vector2

var can_move = true
var can_shoot = true

var credits = 0

var damage = 1
var attack_speed = .2
var virus_movement = 50.0


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
	
	#if can_move:
		#$Container.look_at(get_global_mouse_position())
		#
		#vel.x = Input.get_axis('ui_left', 'ui_right') * move_speed
		#vel.y = Input.get_axis('ui_up', 'ui_down') * move_speed
		#
		#velocity = vel
		#
		#move_and_slide()


func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('ui_up') and check_col('up'):
		global_position.y -= 32.0
	elif Input.is_action_just_pressed('ui_down') and check_col('down'):
		global_position.y += 32.0


func check_col(dir: String = 'up'):
	if dir == 'up':
		return !$RayCast2D2.is_colliding()
	elif dir == 'down':
		return !$RayCast2D.is_colliding()
	
	#if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding():
		#return false
	
	return true


func shoot():
	var b = get_parent().get_active_bullet()
	
	can_shoot = false
	$ShootCooldown.start(attack_speed)
	
	if b:
		b.damage = damage
		b.global_position = global_position
		#b.look_at(get_global_mouse_position())
		#b.dir = global_position.direction_to(get_global_mouse_position())
		b.dir = Vector2.RIGHT
		b.is_active = true
		
		$Laser.play()
		
		get_parent().add_child(b)


func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
