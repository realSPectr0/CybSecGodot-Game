@tool

extends HBoxContainer


@export var title = '' :
	set(value):
		title = value
		
		$Label.text = title


@export var detail = '':
	set(value):
		detail = value
		
		$Label2.text = detail
