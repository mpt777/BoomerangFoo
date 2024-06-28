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
	self.avatar().anchor_register.anchor(Enums.AnchorAlias.RIGHT_HAND).add(n_wand.n_mesh)
	self.avatar().add_cosmetics(self.data.cosmetics)
		
func _physics_process(_delta: float) -> void:
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
	
#func _add_cosmetics():
	#var _ac = func(cosmetic):
		#var c = cosmetic.instance_scene()
		#add_child(c)
		#anchors.add(cosmetic.alias, c)
		#
	#for cosmetic in self.data.cosmetics:
		#_ac.call(cosmetic)
		#
	#for cosmetic in self.data.avatar.default_cosmetics:
		#var anchor = anchors.anchor(cosmetic.alias)
		#if not anchor:
			#continue
		#if anchor.nodes:
			#continue
		#_ac.call(cosmetic)
	
