extends Node2D


func _ready() -> void:
	var t = create_tween()
	t.tween_property(self, 'global_position:y', global_position.y - 16, .5)
	t.tween_property(self, 'modulate:a', 0.0, .3)
	
	await t.finished
	
	queue_free()
