extends Area2D

signal zero
signal hit

var hp = 1


func take_damage(amount = 1):
	hp -= amount
	
	hit.emit()
	
	if hp <= 0:
		zero.emit()
