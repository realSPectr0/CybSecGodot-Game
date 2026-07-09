extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var player_in_range = false
var player_ref = null

func _process(_delta):
	face_player()
	animated_sprite.play()
	# Check if player is nearby AND Space (ui_accept) is pressed
	if player_in_range and Input.is_key_pressed(KEY_SPACE) and not player_ref.interacting:
		#face_player()
		player_ref.interacting = true
		if GameSaveOrLoad.finished_levels < 1:
			#Dialogic.start('transition_to_level1')
			#await Dialogic.timeline_ended
			GameSaveOrLoad.save_game($"../player".global_position)
			SceneChanger.change_scene('res://scenes/level1.tscn')
		else:
			#Dialogic.start('level1_done')
			#await Dialogic.timeline_ended
			player_ref.interacting = false

func face_player():
	if not player_ref: 
		return
	
	# Calculate the direction from NPC to Player
#s	var direction_to_player = (player_ref.global_position - global_position).normalize()
	var dx = player_ref.global_position.x - global_position.x
	var dy = player_ref.global_position.y - global_position.y
	# Determine which direction is "strongest" (Up, Down, Left, or Right)
	if abs(dx) > abs(dy):
		if dx > 0:
			animated_sprite.play("idle_right")
		else:
			animated_sprite.play("idle_left")
	else:
		if dy > 0:
			animated_sprite.play("idle_down")
		else:
			animated_sprite.play("idle_up")

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
