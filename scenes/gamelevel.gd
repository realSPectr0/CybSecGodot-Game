extends Node2D

@onready var player_ref = %player
var level_finished = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SEMICOLON):
		save_game()
func save_game():
	var data = {
		'player_position': player_ref.global_position,
		"level": level_finished
	}
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	file.store_var(data)
	file.close()
