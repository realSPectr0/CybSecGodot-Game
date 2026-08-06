extends Stage


var data = {}


func _ready() -> void:
	data = GameManager.get_data('res://scenes/minigames/osint/browser_tracking/data.json')
	
	var count = 0
	for i in $HBoxContainer.get_children():
		$HBoxContainer.get_child(count).get_child(0).get_child(0).get_node('Title').text = 'Session %s' % data['data'][count]['session_id']
		
		$HBoxContainer.get_child(count).get_child(0).get_child(2).get_node('Label2').text = data['data'][count]['session_id']
		$HBoxContainer.get_child(count).get_child(0).get_child(3).get_node('Label2').text = data['data'][count]['cookie_id']
		$HBoxContainer.get_child(count).get_child(0).get_child(4).get_node('Label2').text = data['data'][count]['browser']
		$HBoxContainer.get_child(count).get_child(0).get_child(5).get_node('Label2').text = data['data'][count]['operating_system']
		$HBoxContainer.get_child(count).get_child(0).get_child(6).get_node('Label2').text = data['data'][count]['screen_resolution']
		$HBoxContainer.get_child(count).get_child(0).get_child(7).get_node('Label2').text = data['data'][count]['language']
		$HBoxContainer.get_child(count).get_child(0).get_child(8).get_node('Label2').text = data['data'][count]['timezone']
		$HBoxContainer.get_child(count).get_child(0).get_child(9).get_node('Label2').text = data['data'][count]['ip_region']
		$HBoxContainer.get_child(count).get_child(0).get_child(10).get_node('Label2').text = data['data'][count]['referrer']
		$HBoxContainer.get_child(count).get_child(0).get_child(11).get_node('Label2').text = data['data'][count]['visit_time']
		$HBoxContainer.get_child(count).get_child(0).get_child(12).get_node('Label2').text = 'true' if data['data'][count]['vpn_detected'] else 'false'
		
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
