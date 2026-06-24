extends Area2D


@onready var email_canvas = $email_canvas

var player_in_bound = false
var player_ref = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	email_canvas.hide() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_bound and Input.is_action_just_pressed("ui_accept") and not player_ref.interacting:
		email_canvas.show()
		player_ref.interacting = true
			
func _on_body_entered(body: Node2D):
	if body.name == 'player':
		player_ref = body
		player_in_bound = true
func _on_body_exited(body: Node2D):
	if body.name == 'player':
		player_in_bound = false
		player_ref.interacting = false
		player_ref = null
		
func _on_timeline_ended():
	#if player_ref:
		#player_ref.interacting = false
	pass
