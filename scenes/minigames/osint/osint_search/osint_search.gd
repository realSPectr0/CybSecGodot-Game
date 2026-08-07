extends Stage

var data = {}

func _ready() -> void:
	$TabContainer.current_tab = 0
	
	data = GameManager.get_data('res://scenes/minigames/osint/osint_search/osint_search_data.json')
	
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Username".text = '@%s' % data['social_post']['username']
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Name".text = data['social_post']['display_name']
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Date".text = data['social_post']['timestamp']
	$"TabContainer/Social Media/SocialPost/Caption".text = data['social_post']['text']
	
	var count = 0
	for i in data['events']:
		$TabContainer/Events/VBoxContainer/Events.get_child(count).get_node('Box').get_node('Title').text = i['location']
		$TabContainer/Events/VBoxContainer/Events.get_child(count).get_node('Box').get_node('Title2').text = i['event']
		$TabContainer/Events/VBoxContainer/Events.get_child(count).get_node('Box').get_node('Time').text = i['time']
		$TabContainer/Events/VBoxContainer/Events.get_child(count).get_node('Box').get_node('Location').text = i['venue']
		
		count += 1
	
	count = 0
	for i in data['weather']:
		$TabContainer/Weather/VBoxContainer/WeatherDisplayContainer.get_child(count).get_node('Box').get_node('Title').text = i['location']
		$TabContainer/Weather/VBoxContainer/WeatherDisplayContainer.get_child(count).get_node('Box').get_node('Vis').text = i['condition']
		$TabContainer/Weather/VBoxContainer/WeatherDisplayContainer.get_child(count).get_node('Box').get_node('Temp').text = '%d°F' % i['temperature_f']
		$TabContainer/Weather/VBoxContainer/WeatherDisplayContainer.get_child(count).get_node('Box').get_node('Detail').text = i['detail']
		
		count += 1
