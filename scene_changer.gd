extends CanvasLayer

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	# Start with the screen completely clear
	color_rect.modulate.a = 0
	color_rect.visible = false

## Call this function from anywhere to change scenes smoothly!
func change_scene(target_scene_path: String) -> void:
	color_rect.visible = true
	
	# Fade to black
	anim_player.play("fade")
	await anim_player.animation_finished
	
	# Swap the actual world scene underneath the mask
	var error = get_tree().change_scene_to_file(target_scene_path)
	if error != OK:
		push_error("Failed to load scene path: " + target_scene_path)
	
	# Fade back into the new scene
	anim_player.play_backwards("fade")
	await anim_player.animation_finished
	
	color_rect.visible = false
