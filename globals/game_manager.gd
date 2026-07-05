extends Node


var minigame_ref

var previous_location : Vector2


func start_minigame():
	if minigame_ref == null:
		return
	
	#var player = get_tree().get_nodes_in_group("Player")[0]
	#player.pop_to_ui(minigame_ref)
	#player.freeze = true
	
	get_tree().change_scene_to_packed(minigame_ref)
	
	minigame_ref = null
