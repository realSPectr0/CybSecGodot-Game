extends Stage


var data = {}


func _ready() -> void:
	data = GameManager.get_data('res://scenes/minigames/osint/browser_tracking/data.json')
	
	var count = 0
	for i in $HBoxContainer.get_children():
		
		
		count += 1
	
	for i in $CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_children():
		i.pressed.connect(on_button_choose.bind(i))


func show_question():
	$CanvasLayer/QuestionPanel/Result.hide()
	$CanvasLayer/QuestionPanel.show()
	
	$CanvasLayer/QuestionPanel/VBoxContainer/QuestionText.text = data['question']
	
	var count = 0
	for i in data['answers']:
		$CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_child(count).text = '%s. %s' % [i['id'], i['text']]
		$CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_child(count).set_meta('id', i['id'])
		
		count += 1


func on_button_choose(ref):
	$CanvasLayer/QuestionPanel/Result.show()
	if ref.get_meta('id') == data['correct_answer']:
		$CanvasLayer/QuestionPanel/Result/Result2.text = 'Correct!'
		$CanvasLayer/QuestionPanel/Result/Result2.set('theme_override_colors/font_color', Color.SEA_GREEN)
		$CanvasLayer/QuestionPanel/Result.text = data['reason']
		
		$CanvasLayer/QuestionPanel/Result/Complete.show()
	else:
		$CanvasLayer/QuestionPanel/Result/Result2.text = 'Wrong!'
		$CanvasLayer/QuestionPanel/Result/Result2.set('theme_override_colors/font_color', Color.DARK_RED)
		$CanvasLayer/QuestionPanel/Result.text = data['teaching_note']


func _on_finish_pressed() -> void:
	show_question()


func _on_question_close_pressed() -> void:
	if $CanvasLayer/QuestionPanel/Result/Complete.visible:
		return
	
	$CanvasLayer/QuestionPanel.hide()


func _on_complete_pressed() -> void:
	
	$CanvasLayer.hide()
	var point_reward = 25
	stage_finished.emit(point_reward)
