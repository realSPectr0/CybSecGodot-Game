extends Area2D

signal zero
signal hit

var hp = 1


func take_damage(amount = 1):
	hp -= amount
	
	hit.emit()
	
	if hp <= 0:
		zero.emit()


func _on_area_entered(area: Area2D) -> void:
	area.get_parent().is_active = false
	
	take_damage()


func _on_body_entered(body: Node2D) -> void:
	take_damage()
