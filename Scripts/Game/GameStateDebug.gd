extends Resource
class_name GameStateDebug

static func default_player_data() -> PlayerData:
	var player_data = PlayerData.new()
	player_data.controller = GameState.register_controller()
	return player_data


static func default_character_data() -> Array:
	var player_data = PlayerData.new()
	player_data.controller = GameState.register_controller()
	player_data.avatar = load("res://Scenes/Entities/Avatar/Witch/witch_data.tres")
	var bot_data = EnemyData.new()
	
	return [player_data, bot_data]
