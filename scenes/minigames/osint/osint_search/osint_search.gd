extends Stage

var data = {}

func _ready() -> void:
	for i in $CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_children():
		i.pressed.connect(on_button_choose.bind(i))
	
	$TabContainer.current_tab = 0
	
	data = GameManager.get_data('res://scenes/minigames/osint/osint_search/osint_search_data.json')
	
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Username".text = '@%s' % data['social_post']['username']
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Name".text = data['social_post']['display_name']
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Date".text = data['social_post']['timestamp']
	$"TabContainer/Social Media/SocialPost/Caption".text = data['social_post']['text']
	
	var count = 0
	for i in data['events']:
		$TabContainer/Events/VBoxContainer/Events.get_child(count).get_node('Box').get_node('Title').text = i['location']
		$TabContainer/Events/VBoxContainer/Events.get_child(count).get_node('Box').get_node('Title2').text = i['event']
		$TabContainer/Events/VBoxContainer/Events.get_child(count).get_node('Box').get_node('Time').text = i['time']
		$TabContainer/Events/VBoxContainer/Events.get_child(count).get_node('Box').get_node('Location').text = i['venue']
		
		count += 1
	
	count = 0
	for i in data['weather']:
		$TabContainer/Weather/VBoxContainer/WeatherDisplayContainer.get_child(count).get_node('Box').get_node('Title').text = i['location']
		$TabContainer/Weather/VBoxContainer/WeatherDisplayContainer.get_child(count).get_node('Box').get_node('Vis').text = i['condition']
		$TabContainer/Weather/VBoxContainer/WeatherDisplayContainer.get_child(count).get_node('Box').get_node('Temp').text = '%d°F' % i['temperature_f']
		$TabContainer/Weather/VBoxContainer/WeatherDisplayContainer.get_child(count).get_node('Box').get_node('Detail').text = i['detail']
		
		count += 1


func show_question():
	$CanvasLayer/QuestionPanel/Result.hide()
	$CanvasLayer/QuestionPanel.show()
	
	var d = GameManager.get_data('res://scenes/minigames/osint/osint_search/osint_search_data.json')
	$CanvasLayer/QuestionPanel/VBoxContainer/QuestionText.text = d['question']
	
	var count = 0
	for i in d['answers']:
		$CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_child(count).text = '%s' % i
		$CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_child(count).set_meta('id', i)
		
		count += 1


func _on_finish_pressed() -> void:
	show_question()


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
		$CanvasLayer/QuestionPanel/Result.text = data['hint']


func _on_complete_pressed() -> void:
	$CanvasLayer.hide()
	
	var point_reward = 20
	stage_finished.emit(point_reward)


func _on_question_close_pressed() -> void:
	if $CanvasLayer/QuestionPanel/Result/Complete.visible:
		return
	
	$CanvasLayer/QuestionPanel.hide()
