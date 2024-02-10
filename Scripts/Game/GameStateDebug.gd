extends Node
class_name GameStateDebug

static func default_player_data() -> PlayerData:
	var player_data = PlayerData.new()
	player_data.controller = player_data.default_controller()
	return player_data


static func default_character_data() -> Array:
	var player_data = PlayerData.new()
	player_data.controller = player_data.default_controller()
	var bot_data = EnemyData.new()
	
	return [player_data, bot_data]
