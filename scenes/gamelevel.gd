extends Node2D

@onready var player_ref = $player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var data = GameSaveOrLoad.load_game()
	print(get_path())
	#print(player_ref, data)
	if data and player_ref:
		#pass
		player_ref.global_position = data.player_position
		
	#pass # Replace with function body.
	
	if GameManager.previous_location != Vector2.ZERO:
		$player.global_position = GameManager.previous_location
		
		GameManager.previous_location = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SEMICOLON):
		GameSaveOrLoad.save_game(player_ref.global_position) # if in space then do Vector2(2450,50)
	
		
