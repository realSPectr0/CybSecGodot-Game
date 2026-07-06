extends Button

signal hovered

@export var desc = ''
@export var cost = 1
@export var upgrade_description = ''


func _on_mouse_entered() -> void:
	hovered.emit(self)
