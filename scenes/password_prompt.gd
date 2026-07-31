extends Control


func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	
	GameManager.global_player_ref.freeze = true
	GameManager.global_player_ref.animated_sprite.play('idle_down')


func _on_close_pressed() -> void:
	GameManager.global_player_ref.freeze = false
	
	queue_free()


func _on_enter_pressed() -> void:
	
	
	get_tree().change_scene_to_packed(GameManager.minigame_ref)
	GameManager.previous_location = GameManager.global_player_ref.global_position
	
	GameManager.minigame_ref = null
