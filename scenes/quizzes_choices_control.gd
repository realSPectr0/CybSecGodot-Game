extends Control


func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	
	GameManager.global_player_ref.freeze = true
	GameManager.global_player_ref.animated_sprite.play('idle_down')


func generate_password():
	pass
