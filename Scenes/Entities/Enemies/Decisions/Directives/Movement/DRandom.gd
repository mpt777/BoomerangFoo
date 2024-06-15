extends Directive
class_name D_Random

var WEIGHT := 20

func decide(enemy : Enemy) -> int:
	if not GameState.settings.settings.get_value("enemy_move", true):
		return 1000000
	if enemy.global_position.distance_squared_to(enemy.n_nav.target_location) < 6:
		return 1
	return 0
	
func apply(enemy : Enemy) -> void:
	if not GameState.settings.settings.get_value("enemy_move", true):
		var spell := Spell.new()
		spell.cost = 3
		enemy.signals.emit_signal("Mana.AddMana", spell)
		return
	enemy.ai.set_new_position(enemy.ai_map.random_position())
	
	
