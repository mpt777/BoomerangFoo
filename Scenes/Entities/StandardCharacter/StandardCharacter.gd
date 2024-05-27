extends Character
class_name StandardCharacter

@onready var n_pointer = $Pointer

func _ready():
	signals.register("Character.Kill", kill)
	$"/root/Signals".connect("start_round", initialize)
	
	n_pointer.set_color(self.data.avatar.color)
	
func initialize():
	self.data.range_projectile.emit_message(self)
	self.data.melee_projectile.emit_message(self)
	
	for modifier in self.data.modifiers:
		modifier.emit_message(self)
		
	anchors.anchor("RightHand").add($Wand.n_mesh)
	
func range_spell() -> Spell:
	return self.data.range_spell
	
func melee_spell() -> Spell:
	return self.data.melee_spell
