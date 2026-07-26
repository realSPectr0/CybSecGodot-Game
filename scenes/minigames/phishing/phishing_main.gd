extends Node2D


var points_total = 0:
	set(value):
		points_total = value

var points_max = 1000


@onready var messages = GameManager.get_data('res://scenes/minigames/phishing/emails_data.json')['emails']

var current_message = {}


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and !event.pressed:
		get_fih()


func _physics_process(delta: float) -> void:
	$UI/TotalPoints.text = '%d/%d' % [points_total, points_max]


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


func _on_legit_pressed() -> void:
	$UI/MessageControl.hide()
	
	if current_message['type'] == 'legit':
		points_total += 75
		pop_correct_or_wrong()
	else:
		pop_correct_or_wrong(false)


func _on_phishing_pressed() -> void:
	$UI/MessageControl.hide()
	
	if current_message['type'] == 'phishing':
		points_total += 75
		pop_correct_or_wrong()
	else:
		pop_correct_or_wrong(false)


func _on_smishing_pressed() -> void:
	$UI/MessageControl.hide()
	
	if current_message['type'] == 'smishing':
		points_total += 75
		pop_correct_or_wrong()
	else:
		pop_correct_or_wrong(false)
