extends Node


var minigame_ref
var minigame_title: String = ''
var quiz_path = ''
var quiz_pass = ''
var quiz_id = ''

var previous_location : Vector2


var character = 'male'

var npc_nearby = null
var global_player_ref

var player_data = {}

var USER_PATH = 'user://player_data.json'


func _ready() -> void:
	player_data = get_data('res://reso/player_data.json')


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_MOUSE_EXIT or what == NOTIFICATION_EXIT_TREE:
		var f = FileAccess.open(USER_PATH, FileAccess.WRITE)
		f.store_string(JSON.stringify(player_data))
		f.close()


func start_minigame():
	if minigame_ref == null:
		return
	
	var e = load('res://scenes/password_prompt.tscn')
	#e.minigame_id = npc_nearby.id
	GameManager.global_player_ref.pop_to_ui(e)
	
	#var player = get_tree().get_nodes_in_group("Player")[0]
	#player.pop_to_ui(minigame_ref)
	#player.freeze = true
	
	#get_tree().change_scene_to_packed(minigame_ref)
	#previous_location = player.global_position
	#
	#minigame_ref = null


func finish_minigame():
	get_tree().change_scene_to_file('res://scenes/gamelevel.tscn')


func start_quiz():
	var e = load('res://scenes/QuizzesChoicesControl.tscn')
	GameManager.global_player_ref.pop_to_ui(e)
	
	GameManager.global_player_ref.freeze = true
	GameManager.global_player_ref.animated_sprite.play('idle_down')


func get_data(path):
	var f = FileAccess.open(path, FileAccess.READ)
	var j = JSON.new()
	j.parse(f.get_as_text())
	
	return j.data
