extends Panel



func _ready() -> void:
	for i in $Images.get_children():
		i.inspected.connect(on_inspected)
	
	for i in $CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_children():
		i.pressed.connect(on_button_choose.bind(i))


func show_file_properties(data):
	$CanvasLayer/FileProperties/Title.text = 'File: %s' % data['filename']
	$CanvasLayer/FileProperties/Panel/VBoxContainer/FileType/Label2.text = data['type']
	$CanvasLayer/FileProperties/Panel/VBoxContainer/Created/Label2.text = data['created']
	if data.has('modified'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Modified.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Modified/Label2.text = data['modified']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Modified.hide()
	
	if data.has('timezone'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Timezone.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Timezone/Label2.text = data['timezone']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Timezone.hide()
	
	
	if data.has('camera'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Camera.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Camera/Label2.text = data['camera']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Camera.hide()
	
	
	if data.has('camera'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Software.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Software/Label2.text = data['editing_software']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Software.hide()
	
	if data.has('gps'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/GPS.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/GPS/Label2.text = data['gps']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/GPS.hide()
	
	if data.has('owner'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Owner.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Owner/Label2.text = data['owner']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Owner.hide()
	
	if data.has('title'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Title.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Title/Label2.text = data['title']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Title.hide()
	
	if data.has('subject'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Subject.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Subject/Label2.text = data['subject']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Subject.hide()
	
	if data.has('software'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/SoftwareFile.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/SoftwareFile/Label2.text = data['software']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/SoftwareFile.hide()
	
	if data.has('page_count'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/PageCount.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/PageCount/Label2.text = '%d' % data['page_count']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/PageCount.hide()
	
	if data.has('author'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Author.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Author/Label2.text =  data['author']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Author.hide()
	
	if data.has('downloaded'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Downloaded.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Downloaded/Label2.text =  data['downloaded']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Downloaded.hide()
	
	if data.has('original_gps_location'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/OrigGPS.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/OrigGPS/Label2.text =  data['original_gps_location']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/OrigGPS.hide()
	
	if data.has('original_photographer'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/OrigPhotographer.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/OrigPhotographer/Label2.text =  data['original_photographer']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/OrigPhotographer.hide()
	
	
	if data.has('source'):
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Source.show()
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Source/Label2.text =  data['source']
	else:
		$CanvasLayer/FileProperties/Panel/VBoxContainer/Source.hide()
	
	$CanvasLayer/FileProperties.show()


func show_question():
	$CanvasLayer/QuestionPanel/Result.hide()
	$CanvasLayer/QuestionPanel.show()
	
	var d = GameManager.get_data('res://scenes/minigames/osint/data/metada_lab_data.json')
	$CanvasLayer/QuestionPanel/VBoxContainer/QuestionText.text = d['question']
	
	var count = 0
	for i in d['answers']:
		$CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_child(count).text = '%s. %s' % [i['id'], i['text']]
		$CanvasLayer/QuestionPanel/VBoxContainer/Buttons.get_child(count).set_meta('id', i['id'])
		
		count += 1


func on_inspected(ref):
	var d = GameManager.get_data('res://scenes/minigames/osint/data/metada_lab_data.json')
	for i in d['files']:
		if i['id'] == ref.id:
			show_file_properties(i)
			break


func on_button_choose(ref):
	var d = GameManager.get_data('res://scenes/minigames/osint/data/metada_lab_data.json')
	
	$CanvasLayer/QuestionPanel/Result.show()
	if ref.get_meta('id') == d['correct_answer']:
		$CanvasLayer/QuestionPanel/Result/Result2.text = 'Correct!'
		$CanvasLayer/QuestionPanel/Result/Result2.set('theme_override_colors/font_color', Color.SEA_GREEN)
		$CanvasLayer/QuestionPanel/Result.text = d['correct_feedback']
	else:
		$CanvasLayer/QuestionPanel/Result/Result2.text = 'Wrong!'
		$CanvasLayer/QuestionPanel/Result/Result2.set('theme_override_colors/font_color', Color.DARK_RED)
		$CanvasLayer/QuestionPanel/Result.text = d['incorrect_feedback']


func _on_close_pressed() -> void:
	$CanvasLayer/FileProperties.hide()


func _on_finish_pressed() -> void:
	show_question()


func _on_question_close_pressed() -> void:
	$CanvasLayer/QuestionPanel.hide()
