extends Node2D

var points = 0

var current_question_idx = 0
var questions = []

func _ready() -> void:
	$CanvasLayer/ProgressBar.max_value = $GameTimer.wait_time
	
	for i in $CanvasLayer/DialogPanel/Choices.get_children():
		i.pressed.connect(on_answer_button_pressed.bind(i.get_index()))
	
	questions = GameManager.get_data('res://scenes/minigames/social_engineering/social_engineering_data.json')
	questions.shuffle()
	
	show_question()


func _physics_process(delta: float) -> void:
	$CanvasLayer/ProgressBar.value = $GameTimer.time_left


func show_question():
	$CanvasLayer/DialogPanel.show()
	$CanvasLayer/DialogPanel/Choices.hide()
	$CanvasLayer/DialogPanel/Text.text = questions[current_question_idx]['question']
	$CanvasLayer/DialogPanel/Text.visible_ratio = 0.0
	var t = create_tween()
	t.tween_property($CanvasLayer/DialogPanel/Text, 'visible_ratio', 1.0, 1.0)
	await t.finished
	
	$CanvasLayer/DialogPanel/Choices.show()
	var count = 0
	for i in questions[current_question_idx]['choices']:
		$CanvasLayer/DialogPanel/Choices.get_child(count).text = i
		
		count += 1


func _on_game_timer_timeout() -> void:
	pass # Replace with function body.


func on_answer_button_pressed(idx):
	pass
