extends EtContainer

func add_bot() -> void:
	var enemy_data = EnemyData.new()
	add_character(enemy_data)
	
func _on_remove_bot_pressed():
	var last_child_data = character_list.get_child(character_list.get_child_count() - 1) as CharacterCircle
	if last_child_data.character_data is EnemyData:
		remove_character(last_child_data.character_data)

func _on_add_bot_pressed():
	add_bot()
