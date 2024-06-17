extends Character
class_name StandardCharacter

@onready var n_pointer : CharacterPointer = $Pointer
@onready var n_wand : Wand = $Wand
@onready var n_mana : ManaComponent = $ManaComponent
@onready var n_hitbox : HitboxComponent = $Hitbox

var _old_position : Vector3
var MOVED : Vector3

func _ready():
	signals.register("Character.Kill", kill)
	$"/root/Signals".connect("start_round", initialize)
	
	n_pointer.set_color(self.data.avatar.color)
	
func initialize():
	self.data.pickups.initialize()
		#modifier.emit_message(self)
		
	anchors.anchor("RightHand").add(n_wand.n_mesh)
		
func _physics_process(delta: float) -> void:
	self.MOVED = self.global_position - self._old_position
	self._old_position = self.global_position
	
func moved():
	return self.global_position - self._old_position
	
func range_spell() -> Spell:
	return self.data.range_spell
	
func melee_spell() -> Spell:
	return self.data.melee_spell
	
func _on_health_component_killed(attack : Attack) -> void:
	$"/root/Signals".emit_signal("add_event", KillEvent.new().constructor(self.data, attack.character))
	signals.emit_signal("Character.Kill")
