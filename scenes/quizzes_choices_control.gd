extends Control

var question_data = {}
var question_idx = 0

var wrong_answers_count = 0
var correct_answers_count = 0

var currently_taking_quiz = null


func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	#generate_password()
	GameManager.global_player_ref.freeze = true
	GameManager.global_player_ref.animated_sprite.play('idle_down')
	
	$QuestionPanel.hide()
	$Panel.show()
	
	for i in $Panel/GridContainer.get_children():
		i.take.connect(func(ref):
			currently_taking_quiz = ref
			
			wrong_answers_count = 0
			correct_answers_count = 0
			question_idx = 0
			question_data = GameManager.get_data(i.quiz_path)
			
			$QuestionPanel.show()
			show_question(0)
			)
	
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
	
	print(new_pass)
	
	return new_pass


func answer_choose(idx):
	var q = question_data['question_%d' % (question_idx+1)] 
	if q['answer_idx'] != idx:
		wrong_answers_count += 1
	else:
		correct_answers_count += 1
	
	question_idx += 1
	
	if question_idx >= question_data.size():
		$QuestionPanel.hide()
		$Panel.show()
		
		if wrong_answers_count <= 0:
			var new_pass = generate_password()
			GameManager.player_data['passwords'][currently_taking_quiz.id] = new_pass
		return
	
	show_question(question_idx)


func _on_close_pressed() -> void:
	GameManager.global_player_ref.freeze = false
	queue_free()


func _on_answer_button_pressed(extra_arg_0: int) -> void:
	answer_choose(extra_arg_0)
