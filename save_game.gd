extends Node

const SAVE_PATH = "user://gamesave.tres"

# Active game data variables
var finished_levels = 1
#var current_scene_path: String = "res://scenes/gamelevel.tscn"
#var player_position: Vector2 = Vector2.ZERO
#var completed_levels: int = 0
## Call this to save everything currently in these variables
func save_game(player_pos=Vector2(2450,50),
				completed_levels=0) -> void:
	var data = SaveData.new()
	
	# Fetch the current player position if they exist in the scene tree
	#var player = get_tree().get_first_node_in_group("Player")
	#if player:
		
	# Get the currently active scene file path
	var current_scene_path = get_tree().current_scene.scene_file_path
	
	# Stuff everything into the file data resource
	#data.player_level = player_level
	#data.found_phishing_emails = found_phishing_emails
	#data.completed_puzzles = completed_puzzles
	data.completed_levels = completed_levels
	data.player_position = player_pos
	data.current_scene_path = current_scene_path
	
	ResourceSaver.save(data, SAVE_PATH)
	print("All data saved successfully!")

## Call this to load everything and restore the game world
func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found!")
		return null
		
	var data = ResourceLoader.load(SAVE_PATH) as SaveData
	if data:
		# 1. Pull all data out of the resource file into our msanager
		#completed_levels = data.completed_levels
		#player_position = data.player_position
		#current_scene_path = data.current_scene_path
		
		print("Data successfully read from file. Changing scenes...")
		
		# 2. Use your custom scene changer to load the correct level
		#if SceneChanger:
			#await SceneChanger.change_scene(current_scene_path)
		#else:
			#get_tree().change_scene_to_file(current_scene_path)
			
		# 3. Wait 1 frame for the new scene to completely load into memory
		#await get_tree().process_frame
		
		# 4. Find the player in the newly loaded scene and put them in their spot
		#var player = get_tree().get_first_node_in_group("Player")
		#if player:
			#player.global_position = player_position
			#print("Player repositioned to: ", player_position)
		return data
