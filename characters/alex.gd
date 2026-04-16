extends CharacterBody2D

const SPEED = 200.0
@onready var animated_sprite = $AnimatedSprite2D

var last_direction = "down"  # Default facing direction

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	velocity = direction * SPEED
	move_and_slide()
	
	update_animation(direction)

func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		# Play idle for whichever way the player is facing
		animated_sprite.play("idle_" + last_direction)
	else:
		# Prioritize horizontal vs vertical based on stronger axis
		if abs(direction.x) >= abs(direction.y):
			if direction.x > 0:
				last_direction = "right"
			else:
				last_direction = "left"
		else:
			if direction.y < 0:
				last_direction = "up"
			else:
				last_direction = "down"
		
		animated_sprite.play("walk_" + last_direction)
