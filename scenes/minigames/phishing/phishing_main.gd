extends Node2D


var points_total = 0:
	set(value):
		points_total = value

var points_max = 1000


@onready var messages = GameManager.get_data('res://scenes/minigames/phishing/emails_data.json')['emails']

var current_message = {}
var points_per_correct_answer = 100


func _ready() -> void:
	$Scout/TextureProgressBar.max_value = $FishCatchTimer.wait_time


#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventScreenTouch and !event.pressed:
		#get_fih()


func _physics_process(delta: float) -> void:
	$UI/TotalPoints.text = '%d/%d' % [points_total, points_max]
	
	$Scout/TextureProgressBar.value = $FishCatchTimer.wait_time - $FishCatchTimer.time_left


func get_fih():
	$Scout.play("pull")
	
	await $Scout.animation_finished
	$Scout.play("idle")
	
	var random_message = messages.pick_random()
	$UI/MessageControl.show()
	$UI/MessageControl/Panel/From.text = random_message['from']
	$UI/MessageControl/Panel/To.text = random_message['to']
	$UI/MessageControl/Panel/Message.parse_bbcode(random_message['message'])
	
	current_message = random_message
	
	get_tree().paused = true



func pop_correct_or_wrong(is_correct = true):
	if is_correct:
		$UI/AfterSelectionPopup/Panel/Label.modulate = Color.GREEN
		$UI/AfterSelectionPopup/Panel/Label.text = 'CORRECT ANSWER!'
	else:
		$UI/AfterSelectionPopup/Panel/Label.modulate = Color.RED
		$UI/AfterSelectionPopup/Panel/Label.text = 'WRONG ANSWER!'
	
	print(is_correct)
	
	$UI/AfterSelectionPopup.show()
	$UI/AfterSelectionPopup/AnimationPlayer.play("new_animation")
	
	await $UI/AfterSelectionPopup/AnimationPlayer.animation_finished
	$UI/AfterSelectionPopup.hide()
	
	get_tree().paused = false
	$FishCatchTimer.start()
	
	if points_total >= points_max:
		game_win()


func game_win():
	get_tree().paused = false
	GameManager.finish_minigame()


func _on_legit_pressed() -> void:
	$UI/MessageControl.hide()
	
	if current_message['type'] == 'legit':
		points_total += points_per_correct_answer
		pop_correct_or_wrong()
	else:
		pop_correct_or_wrong(false)


func _on_phishing_pressed() -> void:
	$UI/MessageControl.hide()
	
	if current_message['type'] == 'phishing':
		points_total += points_per_correct_answer
		pop_correct_or_wrong()
	else:
		pop_correct_or_wrong(false)


func _on_smishing_pressed() -> void:
	$UI/MessageControl.hide()
	
	if current_message['type'] == 'smishing':
		points_total += points_per_correct_answer
		pop_correct_or_wrong()
	else:
		pop_correct_or_wrong(false)


func _on_fish_catch_timer_timeout() -> void:
	get_fih()
