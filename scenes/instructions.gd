extends Area2D

var player_entered = false
var player_ref = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_entered and Input.is_action_just_pressed("ui_accept") and not player_ref.interacting:
		Dialogic.start('phishing_email_instructions')
		player_ref.interacting = true
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		player_entered = true
		player_ref = body
		
		
func _on_timeline_ended():
	if player_ref:
		player_ref.interacting = false

func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		player_entered = false
		player_ref.interacting = false
		player_ref = null
