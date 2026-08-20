extends Node2D

var points = 0

var current_question_idx = 0
var questions = []

var people_sprite_frames = [
	load("res://reso/chars_sprite_frames/char_1.tres"),
	load("res://reso/chars_sprite_frames/char_2.tres"),
	load("res://reso/chars_sprite_frames/char_3.tres"),
	load("res://reso/chars_sprite_frames/char_4.tres"),
	load("res://reso/chars_sprite_frames/char_5.tres"),
]

var can_spawn = true


func _ready() -> void:
	$CanvasLayer/ProgressBar.max_value = $GameTimer.wait_time
	
	for i in $CanvasLayer/DialogPanel/Choices.get_children():
		i.pressed.connect(on_answer_button_pressed.bind(i.get_index()))
	
	questions = GameManager.get_data('res://scenes/minigames/social_engineering/social_engineering_data.json')
	questions.shuffle()
	
	#show_question()


func _physics_process(delta: float) -> void:
	$CanvasLayer/ProgressBar.value = $GameTimer.time_left
	
	$CanvasLayer/Points.text = 'Points: %d' % points


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


func spawn_customer():
	var e = load('res://scenes/minigames/social_engineering/customer.tscn').instantiate()
	e.global_position = $SpawnPoint.global_position
	e.map_ref = self
	e.end_point = $EndPoint.global_position
	e.sprite_frames = people_sprite_frames.pick_random()
	$CustomerContainer.add_child(e)


func _on_game_timer_timeout() -> void:
	$CanvasLayer/GameWinPanel.show()
	$CanvasLayer/GameWinPanel/Panel/Label2.text = 'Total Score: %d' % points


func on_answer_button_pressed(idx):
	if idx == questions[current_question_idx]['correct_answer']:
		$CanvasLayer/Panel.self_modulate = Color.SEA_GREEN
		$CanvasLayer/Panel/Label.text = 'CORRECT!'
		$CanvasLayer/Panel/AnimationPlayer.play("anim")
		
		points += 25
	else:
		$CanvasLayer/Panel.self_modulate = Color.DARK_RED
		$CanvasLayer/Panel/Label.text = 'WRONG!'
		$CanvasLayer/Panel/AnimationPlayer.play("anim")
	
	$CanvasLayer/Panel/Label2.text = questions[current_question_idx]['explanation']
	
	#await $CanvasLayer/Panel/AnimationPlayer.animation_finished
	
	current_question_idx += 1
	
	$CanvasLayer/DialogPanel.hide()
	can_spawn = true
	for i in $CustomerContainer.get_children():
		i.queue_free()
	
	#show_question()


func _on_customer_spawn_timer_timeout() -> void:
	if can_spawn:
		spawn_customer()
		can_spawn = false


func _on_done_pressed() -> void:
	queue_free()
