extends Node2D

var player_bullet_pool = []


@onready var player = $Player

var upgrade_hovered: String = ''
var upgrade_ref = null

func _ready() -> void:
	var b = load('res://scenes/minigames/firewalls_and_viruses/actors/objs/PlayerBullet.tscn')
	for i in 200:
		var e = b.instantiate()
		player_bullet_pool.append(e)
	
	#var p = get_tree().get_nodes_in_group("Player")[0]
	#p.camera.enabled = false
	
	tree_exiting.connect(func():
		GameManager.finish_minigame()
		
		#var player = get_tree().get_nodes_in_group("Player")[0]
		#player.camera.enabled = true
		#if player:
			#player.freeze = false
	)
	
	$UI/GameEndBar.max_value = $GameCompleteTimer.wait_time
	
	for i in $UI/UpgradesControl/Panel/UpgradesBox.get_children():
		i.hovered.connect(upgrade_button_hovered)


func _physics_process(delta: float) -> void:
	$UI/Credits.text = 'Credits: %d' % player.credits
	
	$UI/GameEndBar.value = $GameCompleteTimer.time_left

# game over
func virus_entered():
	get_tree().paused = true
	
	$UI/GameOverControl.show()


func win_game():
	get_tree().paused = true
	
	$UI/GameWinControl.show()


func get_active_bullet():
	for i in player_bullet_pool:
		if i.is_active == false:
			return i


func spawn_enemy():
	var e = load('res://scenes/minigames/firewalls_and_viruses/actors/entities/enemies.tscn').instantiate()
	e.global_position = $SpawnPoints.get_children().pick_random().global_position
	
	add_child(e)


func play_sfx(sound_name: String):
	$Sounds.get_node(sound_name).play()


func _on_enemy_spawn_timer_timeout() -> void:
	spawn_enemy()


func _on_end_area_area_entered(area: Area2D) -> void:
	virus_entered()


func _on_quit_pressed() -> void:
	get_tree().paused = false
	
	queue_free()


func _on_upgrades_pressed() -> void:
	$UI/UpgradesControl.show()


func _on_close_pressed() -> void:
	$UI/UpgradesControl.hide()


func _on_upgrades_control_visibility_changed() -> void:
	if $UI/UpgradesControl.visible:
		get_tree().paused = true
		
		$UI/UpgradesControl/Panel/Credits.text = 'Credits: %d' % player.credits
	else:
		get_tree().paused = false


func _on_difficulty_timer_timeout() -> void:
	$EnemySpawnTimer.wait_time -= .5


func _on_game_complete_timer_timeout() -> void:
	win_game()


func upgrade_buy(key: String):
	match key:
		'avs':
			player.damage += 1
		'popup_blockers':
			player.virus_movement -= 5
		'update_os':
			player.attack_speed -= .05


func upgrade_button_hovered(ref):
	upgrade_ref = ref
	
	$UI/UpgradesControl/Panel/Description.text = ref.desc
	
	$UI/UpgradesControl/Panel/UpgradeDesc.text = ref.upgrade_description
	$UI/UpgradesControl/Panel/Buy.text = 'Buy Upgrade %d' % ref.cost
	$UI/UpgradesControl/Panel/Buy.show()
	$UI/UpgradesControl/Panel/Buy.disabled = true if player.credits < ref.cost else false


func _on_buy_pressed() -> void:
	upgrade_buy(upgrade_ref.id)
	player.credits -= upgrade_ref.cost
	
	$UI/UpgradesControl/Panel/Buy.disabled = true if player.credits < upgrade_ref.cost else false
	$UI/UpgradesControl/Panel/Credits.text = 'Credits: %d' % player.credits
