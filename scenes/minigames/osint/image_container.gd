extends Panel

signal inspected


@export var id = ''

var data = {}


func _ready() -> void:
	var d = GameManager.get_data('res://scenes/minigames/osint/data/metada_lab_data.json')
	for i in d['files']:
		if i['id'] == id:
			data = i
			break
	
	$VBoxContainer/HBoxContainer/VBoxContainer/Title.text = data['filename']
	$VBoxContainer/HBoxContainer/VBoxContainer/Title2.text = data['type']


func _on_inspect_pressed() -> void:
	inspected.emit(self)
