

extends VBoxContainer


@export var title = '':
	set(value):
		title = value
		
		$Label.text = title

@export var id = ''


func _ready() -> void:
	$Label.text = title
	
	if GameManager.player_data['passwords'][id] != '':
		$Status.text = GameManager.player_data['passwords'][id]
