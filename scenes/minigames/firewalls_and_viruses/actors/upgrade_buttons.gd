extends Button

signal hovered

@export var desc = ''


func _on_mouse_entered() -> void:
	hovered.emit(self)
