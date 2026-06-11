extends Area2D

var player_entered = false
var player_ref = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_entered and Input.is_action_just_pressed("ui_accept"):
		start_dialogue()
	
func start_dialogue() -> void:
	print('Instructions are:\nThere are three emails you will need to look at. \nBased on the information from your video, \nspot the problems and click it.')
			
func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		player_entered = true
		player_ref = body
		

func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		player_entered = false
		player_ref = null
