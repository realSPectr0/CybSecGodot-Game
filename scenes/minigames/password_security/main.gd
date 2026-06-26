extends Node2D


enum REQS{
	SPECIAL_CHARACTER,
	LOWERCASE_CHARACTER,
	UPPERCASE_CHARACTER,
	NUMBER,
}

var level = 1
var level_max = 5

var generated_requirements_length = 0
var requirements = []

var special_chars = '!@#$%^&*'
var chars = 'qwertyuiopasdfghjklzxcvbnm'
var numbers = '1234567890'

var password_patterns = [
	[['SPECIAL_CHARACTER', 1],
	['UPPERCASE_CHARACTER', 1],
	['LOWERCASE_CHARACTER', 5],
	['NUMBER', 2]],
	
	[['SPECIAL_CHARACTER', 1],
	['UPPERCASE_CHARACTER', 3],
	['LOWERCASE_CHARACTER', 3],
	['NUMBER', 1]],
	
	[['SPECIAL_CHARACTER', 2],
	['UPPERCASE_CHARACTER', 1],
	['LOWERCASE_CHARACTER', 5]],
	
	[['SPECIAL_CHARACTER', 1],
	['UPPERCASE_CHARACTER', 1],
	['LOWERCASE_CHARACTER', 4],
	['SPECIAL_CHARACTER', 1],
	['NUMBER', 1]],
	
	[['SPECIAL_CHARACTER', 1],
	['UPPERCASE_CHARACTER', 1],
	['LOWERCASE_CHARACTER', 7],
	['NUMBER', 3]],
	
	[['UPPERCASE_CHARACTER', 1],
	['LOWERCASE_CHARACTER', 6],
	['NUMBER', 3]],
]


func _ready() -> void:
	generate_password_requirement()
	
	$CanvasLayer/Popups/Control.hide()


func generate_password_requirement():
	requirements = password_patterns.pick_random()
	generated_requirements_length = 0
	
	for i in $CanvasLayer/Control/Requirements.get_children():
		i.queue_free()
	
	for i in requirements:
		var e = load('res://scenes/minigames/password_security/requirement.tscn').instantiate()
		e.requirement_id = i[0]
		e.amount = i[1]
		
		match i[0]:
			'SPECIAL_CHARACTER': e.get_node('Label').text = '%d Special Character(s)' % i[1]
			'UPPERCASE_CHARACTER': e.get_node('Label').text = '%d Uppercase Character(s)' % i[1]
			'NUMBER': e.get_node('Label').text = '%d Number(s)' % i[1]
			'LOWERCASE_CHARACTER': e.get_node('Label').text = '%d Lowercase Character(s)' % i[1]
		
		$CanvasLayer/Control/Requirements.add_child(e)
	
	for i in requirements:
		generated_requirements_length += i[1]


func check_password():
	for i in $CanvasLayer/Control/Requirements.get_children():
		i.set_check(false)
	
	if $CanvasLayer/Control/Password.text == '' or $CanvasLayer/Control/Password.text.length() < generated_requirements_length:
		return false
	
	var text: String = $CanvasLayer/Control/Password.text
	
	var count = 0
	var count_max = 0
	var req_idx = 0
	for i in text:
		if req_idx >= requirements.size():
			return false
		count_max = requirements[req_idx][1]
		
		if count < count_max:
			if requirements[req_idx][0] == 'SPECIAL_CHARACTER':
				if special_chars.contains(i):
					count += 1
				else:
					return false
			
			if requirements[req_idx][0] == 'LOWERCASE_CHARACTER':
				if chars.contains(i):
					count += 1
				else:
					return false
			
			if requirements[req_idx][0] == 'UPPERCASE_CHARACTER':
				if chars.contains(i.to_lower()) and i == i.to_upper():
					count += 1
				else:
					return false
			
			if requirements[req_idx][0] == 'NUMBER':
				if numbers.contains(i):
					count += 1
				else:
					return false
			
			if count >= count_max:
				$CanvasLayer/Control/Requirements.get_child(req_idx).set_check(true)
				count = 0
				req_idx += 1
		#else:
			#count = 0
			#req_idx += 1
	
	return true


func _physics_process(delta: float) -> void:
	var d = $CanvasLayer/Control/ColorRect.material.get('shader_parameter/time_val')
	$CanvasLayer/Control/ColorRect.material.set('shader_parameter/time_val', d + delta)
	
	$CanvasLayer/Control/Password/PasswordShadow.text = $CanvasLayer/Control/Password.text
	
	if $CanvasLayer/Popups/Control.visible:
		$CanvasLayer/Popups/Control/Panel/ProgressBar.value = $CanvasLayer/Popups/Control/Timer.time_left


func _on_password_text_changed(new_text: String) -> void:
	$Node.get_children().pick_random().play()
	$CanvasLayer/Control/Password/Submit.visible = check_password()


func _on_submit_pressed() -> void:
	$CanvasLayer/Popups/Control/Timer.start()
	$CanvasLayer/Popups/Control/Panel/ProgressBar.value = $CanvasLayer/Popups/Control/Timer.time_left
	$CanvasLayer/Popups/Control/Panel/ProgressBar.max_value = $CanvasLayer/Popups/Control/Timer.wait_time
	$CanvasLayer/Popups/Control/Panel/ProgressBar/Level.text = 'Next: Level %d' % level
	
	$CanvasLayer/Popups/Control.show()


func _on_timer_timeout() -> void:
	print('level failed, you dont remember the password!')
	
	generate_password_requirement()
	$CanvasLayer/Control/Password.clear()
	$CanvasLayer/Popups/Control.hide()


func _on_complete_level_pressed() -> void:
	generate_password_requirement()
	$CanvasLayer/Control/Password.clear()
	$CanvasLayer/Popups/Control.hide()
	$CanvasLayer/Popups/Control/Panel/RetypePassword.clear()
	
	$CanvasLayer/Popups/Control/Timer.stop()
	
	level += 1


func _on_retype_password_text_changed(new_text: String) -> void:
	if $CanvasLayer/Control/Password.text == new_text:
		$CanvasLayer/Popups/Control/Panel/RetypePassword/CompleteLevel.show()
		$CanvasLayer/Popups/Control/Panel/RetypePassword/WrongPass.hide()
	else:
		$CanvasLayer/Popups/Control/Panel/RetypePassword/CompleteLevel.hide()
		$CanvasLayer/Popups/Control/Panel/RetypePassword/WrongPass.show()
