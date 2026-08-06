extends Stage

var data = {}

func _ready() -> void:
	data = GameManager.get_data('res://scenes/minigames/osint/osint_search/osint_search_data.json')
