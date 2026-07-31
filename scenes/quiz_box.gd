extends VBoxContainer


signal take


@export var title = '':
	set(value):
		title = value
		
		$Label.text = title

@export var id = ''
@export var quiz_path = ''


func _ready() -> void:
	$Label.text = title
	
	if GameManager.player_data['passwords'][id] != '':
		$Status.text = GameManager.player_data['passwords'][id]
		
		$TakeQuiz.disabled = true


func _on_take_quiz_pressed() -> void:
	take.emit(self)
