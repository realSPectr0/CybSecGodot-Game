extends Panel

signal answered(points)
signal finished

var data = {
	"questions": {
		"question_0": {
			"text": "Where is Alex most likely located?",
			"options": [
				"Harbor Point",
				"Metro Center",
				"Pine Ridge",
				"St. Bernard",
			],
			"answer": 0
		},
		"question_1": {
			"text": "Which evidence was misleading?",
			"options": [
				"The Desert Springs GPS tag from the stock photo",
				"The browser's version",
				"Session B’s Metro Center IP region caused by the VPN",
				"The account is fake and all their posts",
			],
			"answer": 0
		},
		"question_2": {
			"text": "Select two privacy mistakes Alex made.",
			"options": [
				"Leaving consistent timestamps and time-zone information in files",
				"Using Firefox",
				"Taking landscape photos",
				"Allowing a persistent cookie to connect browser sessions",
			],
			"answers": [0, 3]
		}
	}
}

var question_idx = 0

var third_question_answers_selected = []


func _ready() -> void:
	for i in $VBoxContainer/Buttons.get_children():
		i.pressed.connect(on_button_choose.bind(i))


func _physics_process(delta: float) -> void:
	$Title.text = 'Final Question %d/%d' % [question_idx + 1, 4]


func show_question(idx):
	$VBoxContainer/QuestionText.text = data['questions']['question_%d' % question_idx]['text']
	
	var count = 0
	for i in data['questions']['question_%d' % question_idx]['options']:
		$VBoxContainer/Buttons.get_child(count).text = i
		$VBoxContainer/Buttons.get_child(count).set_meta('id', count)
		
		count += 1


func on_button_choose(ref):
	if data['questions']['question_%d' % question_idx].has('answers'):
		if third_question_answers_selected.has(ref) == false:
			third_question_answers_selected.append(ref)
		
		var score_accu = 0
		if third_question_answers_selected.size() >= 2:
			var count = 0
			for i in data['questions']['question_%d' % question_idx]['answers']:
				if i == third_question_answers_selected[count].get_meta('id'):
					
					score_accu += 5
					
					count += 1
		else:
			return
		
		answered.emit(score_accu)
	elif ref.get_meta('id') == data['questions']['question_%d' % question_idx]['answer']:
		match question_idx:
			0: answered.emit(15)
			1: answered.emit(5)
			#2: answered.emit(10)
	
	for i in $VBoxContainer/Buttons.get_children():
		i.release_focus()
		i.button_pressed = false
	
	question_idx += 1
	if question_idx < 3:
		show_question(question_idx)
	else:
		$VBoxContainer.hide()
		$SliderContainer.show()
		
	
	return
	
	$CanvasLayer/QuestionPanel/Result.show()
	if ref.get_meta('id') == data['correct_answer']:
		$CanvasLayer/QuestionPanel/Result/Result2.text = 'Correct!'
		$CanvasLayer/QuestionPanel/Result/Result2.set('theme_override_colors/font_color', Color.SEA_GREEN)
		$CanvasLayer/QuestionPanel/Result.text = data['correct_feedback']
		
		$CanvasLayer/QuestionPanel/Result/Complete.show()
	else:
		$CanvasLayer/QuestionPanel/Result/Result2.text = 'Wrong!'
		$CanvasLayer/QuestionPanel/Result/Result2.set('theme_override_colors/font_color', Color.DARK_RED)
		$CanvasLayer/QuestionPanel/Result.text = data['incorrect_feedback']


func _on_visibility_changed() -> void:
	if visible:
		show_question(0)


func _on_h_slider_value_changed(value: float) -> void:
	$SliderContainer/Amount.text = '%d%%' % value


func _on_finish_pressed() -> void:
	finished.emit()
