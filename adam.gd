extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var player_in_range = false
var player_ref = null

func _process(_delta):
	print('player_nearby')
	face_player()
	# Check if player is nearby AND Space (ui_accept) is pressed
	if player_in_range and Input.is_key_pressed(KEY_SPACE):
		#face_player() 
		start_dialogue()

func face_player():
	if not player_ref: return
	
	# Calculate the direction from NPC to Player
	var direction_to_player = (player_ref.global_position - global_position).normalize()
	print(direction_to_player.x, direction_to_player.y)
	# Determine which direction is "strongest" (Up, Down, Left, or Right)
	if abs(direction_to_player.x) > abs(direction_to_player.y):
		if direction_to_player.x > 0:
			animated_sprite.play("idle_right")
			print('right')
		else:
			animated_sprite.play("idle_left")
			print('left')
	else:
		if direction_to_player.y > 0:
			animated_sprite.play("idle_down")
			print('down')
		else:
			animated_sprite.play("idle_up")
			print('up')

func start_dialogue():
	pass
		# Trigger your phishing quiz or text box here

# Signal from the NPC's Area2D
func _on_interaction_area_body_entered(body):
	if body.name == "player":
		player_in_range = true
		player_ref = body
		

# Signal from the NPC's Area2D
func _on_interaction_area_body_exited(body):
	if body.name == "player":
		player_in_range = false
		player_ref = null
