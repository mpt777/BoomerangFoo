extends EtContainer

@export var next_et_container : EtContainer
@onready var n_remove_bot : Button = $Bots/HBoxContainer/RemoveBot

	
func _on_add_bot_pressed():
	$"/root/Signals".emit_signal("add_bot")
	
func _on_remove_bot_pressed():
	$"/root/Signals".emit_signal("remove_bot")

func _on_add_bots_controller_pressed(args):
	self._on_add_bots_pressed()
	
func _on_add_bots_pressed():
	self.next_et_container.enter()
	self.exit()
