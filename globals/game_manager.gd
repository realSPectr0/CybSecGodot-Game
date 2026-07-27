extends Node


var minigame_ref
var minigame_title: String = ''

var previous_location : Vector2


var character = 'male'

var npc_nearby = null
var global_player_ref


func start_minigame():
	if minigame_ref == null:
		return
	
	var player = get_tree().get_nodes_in_group("Player")[0]
	#player.pop_to_ui(minigame_ref)
	#player.freeze = true
	
	get_tree().change_scene_to_packed(minigame_ref)
	previous_location = player.global_position
	
	minigame_ref = null


func finish_minigame():
	get_tree().change_scene_to_file('res://scenes/gamelevel.tscn')


func get_data(path):
	var f = FileAccess.open(path, FileAccess.READ)
	var j = JSON.new()
	j.parse(f.get_as_text())
	
	return j.data
