extends Node2D


var points_total = 0
var points_max = 1000


@onready var messages = GameManager.get_data('res://scenes/minigames/phishing/emails_data.json')['emails']


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and !event.pressed:
		get_fih()


func get_fih():
	$Scout.play("pull")
	
	var random_message = messages.pick_random()
	$UI/MessageControl.show()
	$UI/MessageControl/Panel/From.text = random_message['from']
	$UI/MessageControl/Panel/To.text = random_message['to']
	$UI/MessageControl/Panel/Message.parse_bbcode(random_message['message'])
	
	await $Scout.animation_finished
	$Scout.play("idle")


func _on_legit_pressed() -> void:
	$UI/MessageControl.hide()


func _on_phishing_pressed() -> void:
	pass # Replace with function body.


func _on_smishing_pressed() -> void:
	pass # Replace with function body.
