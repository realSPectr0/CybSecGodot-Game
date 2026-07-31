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


func show_question(idx):
	$QuestionPanel/VBoxContainer/QuestionText.text = question_data['question_%d' % (idx + 1)]['text']
	
	var count = 0
	for i in question_data['question_%d' % (idx + 1)]['choices']:
		$QuestionPanel/VBoxContainer/Buttons.get_child(count).text = i
		
		count += 1


func generate_password():
	pass
