extends HBoxContainer


var requirement_id = ''
var amount = 1


func set_check(b: bool):
	if b:
		$Check.visible = true
		$Uncheck.visible = false
	else:
		$Check.visible = false
		$Uncheck.visible = true
