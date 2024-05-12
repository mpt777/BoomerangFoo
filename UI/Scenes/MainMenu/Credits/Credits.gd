extends EtContainer

@export var exit_container : EtContainer


func _on_exit_pressed() -> void:
	self.exit()
	self.exit_container.enter()
