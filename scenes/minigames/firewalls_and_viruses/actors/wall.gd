extends Sprite2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	var e = load("res://scenes/minigames/firewalls_and_viruses/actors/objs/explosion.tscn").instantiate()
	e.global_position = global_position
	get_parent().get_parent().add_child(e)
	
	queue_free()
