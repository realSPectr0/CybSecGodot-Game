extends CharacterBody2D

var move_speed = 150.0
var vel: Vector2

var can_move = true
var can_shoot = true


func _physics_process(delta: float) -> void:
	if can_move:
		$Container.look_at(get_global_mouse_position())
		
		vel.x = Input.get_axis('ui_left', 'ui_right') * move_speed
		vel.y = Input.get_axis('ui_up', 'ui_down') * move_speed
		
		velocity = vel
		
		move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and can_shoot:
		shoot()


func shoot():
	pass
