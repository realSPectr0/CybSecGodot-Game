extends Control


func _on_play_pressed() -> void:
	#get_tree().change_scene_to_file('res://scenes/gamelevel.tscn')
	
	$ChooseCharacterControl.show()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_female_pressed() -> void:
	GameManager.character = 'female'
	get_tree().change_scene_to_file('res://scenes/gamelevel.tscn')


func _on_play_male_pressed() -> void:
	GameManager.character = 'male'
	get_tree().change_scene_to_file('res://scenes/gamelevel.tscn')
