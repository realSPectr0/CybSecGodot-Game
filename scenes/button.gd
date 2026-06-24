extends Button

@export_file_path('scenes/gamelevel.tscn') var lobby

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	SceneChanger.change_scene(lobby)
