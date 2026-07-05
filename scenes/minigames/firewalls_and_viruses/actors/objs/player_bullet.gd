extends Node2D

var damage = 1


var is_active = false: 
	set(value):
		is_active = value
		
		if is_active:
			set_physics_process(true)
		else:
			damage = 1
			set_physics_process(false)
			get_parent().remove_child(self)

var move_speed = 300.0
var dir


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	global_position += dir * move_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	is_active = false
	
	#get_parent().remove_child(self)
