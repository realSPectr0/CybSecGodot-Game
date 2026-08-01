extends Node2D

@export var title = ''
@export var id = ''
@export var quiz_path = ''


func _ready() -> void:
	DialogueManager.dialogue_ended.connect(func(res):
		GameManager.global_player_ref.freeze = false
		)


func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.minigame_title = title
	GameManager.quiz_path = quiz_path
	
	GameManager.global_player_ref.freeze = true
	GameManager.global_player_ref.animated_sprite.play('idle_down')
	
	var res = load('res://reso/quizzes_learn.dialogue')
	DialogueManager.show_dialogue_balloon(res, 'start')
