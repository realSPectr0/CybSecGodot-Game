extends Control

var question_data = {}
var question_idx = 0


func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	
	GameManager.global_player_ref.freeze = true
	GameManager.global_player_ref.animated_sprite.play('idle_down')
	
	$QuestionPanel.hide()
	$Panel.show()
	
	for i in $Panel/GridContainer.get_children():
		i.take.connect(func(ref):
			question_data = GameManager.get_data(i.quiz_path)
			
			$QuestionPanel.show()
			show_question(0)
			)
	
	for b in $QuestionPanel/VBoxContainer/Buttons.get_children():
		b.pressed.connect(func():
			question_idx += 1
			
			if question_idx >= question_data.size():
				$QuestionPanel.hide()
				$Panel.show()
				return
			
			show_question(question_idx)
			)


func _physics_process(delta: float) -> void:
	$QuestionPanel/QuestionIDX.text = '%d/%d' % [question_idx + 1, question_data.size()]


func show_question(idx):
	$QuestionPanel/VBoxContainer/QuestionText.text = question_data['question_%d' % (idx + 1)]['text']
	
	var count = 0
	for i in question_data['question_%d' % (idx + 1)]['choices']:
		$QuestionPanel/VBoxContainer/Buttons.get_child(count).text = i
		
		count += 1


func generate_password():
	pass


func _on_close_pressed() -> void:
	GameManager.global_player_ref.freeze = false
	queue_free()
