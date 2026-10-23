extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/minigames/osint/main.tscn')


func _on_instructions_pressed() -> void:
	$InstructionsPanel.show()


func _on_quit_pressed() -> void:
	queue_free()


func _on_okay_pressed() -> void:
	$InstructionsPanel.hide()
