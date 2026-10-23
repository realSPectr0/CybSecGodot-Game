extends Control

var question_data = {}
var question_idx = 0

var wrong_answers_count = 0
var correct_answers_count = 0

var currently_taking_quiz_id = ''


func _ready() -> void:
	$AnswerStatePopup/Panel.hide()
	$AnswerStatePopup/Panel/AnimationPlayer.play("RESET")
	
	await get_tree().create_timer(.5).timeout
	#generate_password()
	GameManager.global_player_ref.freeze = true
	GameManager.global_player_ref.animated_sprite.play('idle_down')
	
	#$QuestionPanel.hide()
	#$Panel.show()
	
	currently_taking_quiz_id = GameManager.quiz_id
	
	question_data = GameManager.get_data(GameManager.quiz_path)
	show_question(0)
	
	$QuestionPanel/Label2.text = GameManager.minigame_title
	$QuestionPanel.show()
	
	#for i in $Panel/GridContainer.get_children():
		#i.take.connect(func(ref):
			#currently_taking_quiz = ref
			#
			#wrong_answers_count = 0
			#correct_answers_count = 0
			#question_idx = 0
			#question_data = GameManager.get_data(i.quiz_path)
			#
			#$QuestionPanel.show()
			#show_question(0)
			#)
	
	#for b in $QuestionPanel/VBoxContainer/Buttons.get_children():
		#b.pressed.connect(func():
			#question_idx += 1
			#
			#if question_idx >= question_data.size():
				#$QuestionPanel.hide()
				#$Panel.show()
				#return
			#
			#show_question(question_idx)
			#)


func _physics_process(delta: float) -> void:
	$QuestionPanel/QuestionIDX.text = '%d/%d' % [question_idx + 1, question_data.size()]


func show_question(idx):
	$QuestionPanel/VBoxContainer/QuestionText.text = question_data['question_%d' % (idx + 1)]['text']
	
	var count = 0
	for i in question_data['question_%d' % (idx + 1)]['choices']:
		$QuestionPanel/VBoxContainer/Buttons.get_child(count).text = i
		
		count += 1


func generate_password():
	var alphabet = 'QWERTYUIOPASDFGHJKLZXCVBNM'
	var nums = '1234567890'
	var new_pass = ''
	
	
	for i in 3:
		var rand = randi_range(0, alphabet.length() - 1)
		new_pass += alphabet.split('')[rand]
	for i in 3:
		var rand = randi_range(0, nums.length() - 1)
		new_pass += nums.split('')[rand]
	
	#print(new_pass)
	
	return new_pass


func answer_choose(idx):
	var q = question_data['question_%d' % (question_idx+1)] 
	if q['answer_idx'] != idx:
		wrong_answers_count += 1
		$AnswerStatePopup/Panel/Label.text = 'WRONG!'
		$AnswerStatePopup/Panel.self_modulate = Color.DARK_RED
		$AnswerStatePopup/Panel.show()
		$AnswerStatePopup/Panel/AnimationPlayer.play("anim")
	else:
		$AnswerStatePopup/Panel.self_modulate = Color.SEA_GREEN
		$AnswerStatePopup/Panel/Label.text = 'CORRECT!'
		correct_answers_count += 1
		$AnswerStatePopup/Panel.show()
		$AnswerStatePopup/Panel/AnimationPlayer.play("anim")
	
	question_idx += 1
	
	if question_idx >= question_data.size():
		$QuestionPanel/PasswordSuccess.show()
		$QuestionPanel/VBoxContainer.hide()
		
		if wrong_answers_count <= 0:
			var new_pass = generate_password()
			GameManager.player_data['passwords'][currently_taking_quiz_id] = new_pass
			
			#$QuestionPanel/PasswordSuccess.font_color = Color.SEA_GREEN
			$QuestionPanel/PasswordSuccess.text = 'You completed the quiz, the password is %s.' % new_pass
		else:
			$QuestionPanel/PasswordSuccess.text = 'You failed the quiz, try again.'
			#$QuestionPanel/PasswordSuccess.font_color = Color.DARK_RED
		return
	
	show_question(question_idx)


func _on_close_pressed() -> void:
	GameManager.global_player_ref.freeze = false
	queue_free()


func _on_answer_button_pressed(extra_arg_0: int) -> void:
	answer_choose(extra_arg_0)


func _on_close_qustion_panel_pressed() -> void:
	$QuestionPanel.hide()
	$Panel.show()
	
	_on_close_pressed()
