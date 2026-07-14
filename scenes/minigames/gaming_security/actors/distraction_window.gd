extends Panel

var res = [
	"res://scenes/minigames/gaming_security/art/cat1.tres",
	"res://scenes/minigames/gaming_security/art/cat2.tres"
]


func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = load(res.pick_random())
	$AnimatedSprite2D.play('default')


func _on_close_pressed() -> void:
	queue_free()
