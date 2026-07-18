extends CharacterBody2D

const SPEED = 200.0
@onready var animated_sprite = $AnimatedSprite2D
@export_file_path('scenes/menu_ui.tscn') var menu_ui_file
var freeze = false
var last_direction = "down"  # Default facing direction
var interacting = false

@onready var camera = $Camera2D

func _ready() -> void:
	if GameManager.character == 'male':
		$AnimatedSprite2D.sprite_frames = load('res://reso/male_char.tres')
	else:
		$AnimatedSprite2D.sprite_frames = load('res://reso/female_char.tres')


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		print(true)
		SceneChanger.change_scene(menu_ui_file)
	#if interacting:
		#freeze = true
	#else:
		#freeze = false
	if freeze:
		set_physics_process(false)
	else:
		set_physics_process(true)


func _physics_process(delta: float) -> void:
	if freeze:
		return
	
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
	#if not freeze:
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


func pop_to_ui(scene):
	for i in $UI/Popup.get_children():
		i.queue_free()
	
	freeze = true
	
	$UI/Popup.add_child(scene.instantiate())
