extends Resource
class_name AI

var character : Enemy
const distance_bounds = Vector2(10, 30)
var movement_directive : AiDirective

func constructor(p_character) -> AI:
	self.character = p_character
	self.movement_directive = AiDirective.new().constructor(
		self.character, [D_AvoidPlayer.new(), D_MoveToPickup.new(), D_Random.new(), D_NoStuck.new(), D_Avoid.new()]
	)
	return self
	
func set_new_position(desired_position: Vector3) -> void:
	self.character.n_nav.target_location = desired_position
