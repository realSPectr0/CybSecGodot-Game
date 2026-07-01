extends Node


var minigame_ref

func start_minigame():
	if minigame_ref == null:
		return
	
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.pop_to_ui(minigame_ref)
	player.freeze = true
	
	minigame_ref = null
