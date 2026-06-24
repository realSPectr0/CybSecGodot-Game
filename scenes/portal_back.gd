extends Area2D

@export_file_path('scenes/level1.tscn') var go_back_scene

var change_scene = false
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if change_scene and Input.is_action_just_pressed("ui_accept"):
		SceneChanger.change_scene(go_back_scene)

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		change_scene = true
		


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		change_scene = false
