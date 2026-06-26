extends Node2D


enum REQS{
	SPECIAL_CHARACTER,
	LOWERCASE_CHARACTER,
	UPPERCASE_CHARACTER,
	NUMBER,
}

var generated_requirements_length = 0
var written_password = ''
var requirements = [
	['SPECIAL_CHARACTER', 1],
	['UPPERCASE_CHARACTER', 1],
	['LOWERCASE_CHARACTER', 5],
	['NUMBER', 2],
]

var special_chars = '!@#$%^&*'
var chars = 'qwertyuiopasdfghjklzxcvbnm'
var numbers = '1234567890'


func _ready() -> void:
	generate_password_requirement()


func generate_password_requirement():
	
	
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
				count = 0
				req_idx += 1
		#else:
			#count = 0
			#req_idx += 1
	
	return true


func _physics_process(delta: float) -> void:
	$CanvasLayer/Control/Password/PasswordShadow.text = $CanvasLayer/Control/Password.text


func _on_password_text_changed(new_text: String) -> void:
	$CanvasLayer/Control/Password/PasswordCheck.visible = check_password()
