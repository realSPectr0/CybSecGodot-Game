extends Node2D

@export var title = ''
@export var id = ''
@export var quiz_path = ''


func _ready() -> void:
	DialogueManager.dialogue_ended.connect(func(res):
		GameManager.global_player_ref.freeze = false
		)


func start_dialogue():
	GameManager.global_player_ref.freeze = true
	GameManager.global_player_ref.animated_sprite.play('idle_down')
	
	if GameManager.player_data['passwords'][id] != '':
		GameManager.quiz_pass = GameManager.player_data['passwords'][id]
		
		var res = load('res://reso/quiz_already_done.dialogue')
		DialogueManager.show_dialogue_balloon(res, 'start')
	else:
		var res = load('res://reso/quizzes_learn.dialogue')
		DialogueManager.show_dialogue_balloon(res, 'start')


func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.npc_nearby = self
	GameManager.global_player_ref.talk_button.text = title
	GameManager.global_player_ref.talk_button.visible = true
	
	GameManager.minigame_title = title
	GameManager.quiz_path = quiz_path
	GameManager.quiz_id = id
	
	#GameManager.global_player_ref.freeze = true
	#GameManager.global_player_ref.animated_sprite.play('idle_down')
	#
	#if GameManager.player_data['passwords'][id] != '':
		#GameManager.quiz_pass = GameManager.player_data['passwords'][id]
		#
		#var res = load('res://reso/quiz_already_done.dialogue')
		#DialogueManager.show_dialogue_balloon(res, 'start')
	#else:
		#var res = load('res://reso/quizzes_learn.dialogue')
		#DialogueManager.show_dialogue_balloon(res, 'start')
