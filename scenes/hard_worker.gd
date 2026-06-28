extends CharacterBody2D

@export var minigame_scene: PackedScene
@export var overhead_title = ''

@onready var animated_sprite = $AnimatedSprite2D

var player_in_range = false
var player_ref = null

func _process(_delta):
	face_player()
	animated_sprite.play()
	# Check if player is nearby AND Space (ui_accept) is pressed
	if player_in_range and Input.is_key_pressed(KEY_SPACE):
		#face_player() 
		Dialogic.start('hard_worker')

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

func start_dialogue():
	if minigame_scene:
		Dialogic.VAR.set('overhead_title', overhead_title)
		var res = load('res://dialogue/worker_dialog.dtl')
		Dialogic.start(res, 'default')
		
		GameManager.minigame_ref = minigame_scene
		
		#var player = get_tree().get_nodes_in_group("Player")[0]
		#player.pop_to_ui(minigame_scene)
	
	#print('what npcs saiy bro')
		# Trigger your phishing quiz or text box here

# Signal from the NPC's Area2D
func _on_interaction_area_body_entered(body):
	if body.name == "player":
		player_in_range = true
		player_ref = body
		
		start_dialogue()

# Signal from the NPC's Area2D
func _on_interaction_area_body_exited(body):
	if body.name == "player":
		player_in_range = false
		player_ref = null
