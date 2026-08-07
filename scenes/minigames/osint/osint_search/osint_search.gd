extends Stage

var data = {}

func _ready() -> void:
	data = GameManager.get_data('res://scenes/minigames/osint/osint_search/osint_search_data.json')
	
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Username".text = '@%s' % data['social_post']['username']
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Name".text = data['social_post']['display_name']
	$"TabContainer/Social Media/SocialPost/Top/VBoxContainer/Date".text = data['social_post']['timestamp']
	$"TabContainer/Social Media/SocialPost/Caption".text = data['social_post']['text']
