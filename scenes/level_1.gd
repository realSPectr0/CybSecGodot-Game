extends Node2D

var levels = 3
var time_to_leave = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#$player.interacting = false
	#Dialogic.timeline_started.connect()
	#Dialogic.timeline_ended.connect(_on_timeline_ended)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if levels >= 3 and not time_to_leave:
		print(true)
		time_to_leave = true
		Dialogic.start('leave_level1')
		GameSaveOrLoad.finished_levels = 1
		await Dialogic.timeline_ended
		#GameSaveOrLoad.save_game($player.global_position)
		SceneChanger.change_scene('res://scenes/gamelevel.tscn')
		
