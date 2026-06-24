extends TextureRect

@onready var ding_sound: AudioStreamPlayer = $"ding"
@onready var submit_button: Button = $"Submit"
@onready var escape_button: Button = $Escape
@onready var player_ref: CharacterBody2D = $'/root/level1/player'

@onready var danger_zones: Array = []

# Keeps track of which danger zone nodes have been successfully clicked
var found_zones: Array = []

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	
	if escape_button:
		escape_button.pressed.connect(_on_escape_pressed)
	if submit_button:
		submit_button.pressed.connect(_on_submit_pressed)
		
	# Loop through each danger zone button and dynamically connect their pressed signals!
	for zone in danger_zones:
		if zone is Button or zone is TextureButton:
			# Pass the specific zone node into our custom function when clicked
			zone.pressed.connect(_on_danger_zone_pressed.bind(zone))

## This runs automatically whenever ANY danger zone button is clicked
func _on_danger_zone_pressed(clicked_zone: Node) -> void:
	clicked_zone.release_focus() # Prevent spacebar issues!
	
	# If this zone wasn't found yet, add it to our tracking array
	if not found_zones.has(clicked_zone):
		found_zones.append(clicked_zone)
		
		# Find the human-readable index (1, 2, etc.) for your print statement
		var zone_index = danger_zones.find(clicked_zone) + 1
		print("Successfully found Danger Zone #", zone_index)

func _on_submit_pressed() -> void:
	submit_button.release_focus()
	
	# Check if the total clicked zones match the total danger zones available
	if found_zones.size() == danger_zones.size() and player_ref.interacting:
		Dialogic.start('correct_email_1')
		if ding_sound:
			ding_sound.play()
		await Dialogic.timeline_ended
		
		$"../../../".levels += 1 # level node
		player_ref.interacting = false
		$"../..".queue_free()
	else:
		Dialogic.start('incorrect')

func _on_escape_pressed() -> void:
	escape_button.release_focus()
	player_ref.interacting = false
	hide_email_menu()

func hide_email_menu() -> void:
	$"../".hide()
