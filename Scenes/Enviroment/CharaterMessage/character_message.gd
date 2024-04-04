extends MarginContainer
class_name CharacterMessage


var seconds : float = 5.0
var color : Color
#@onready
#var n_sprite := $Sprite3D
@onready
var n_timer := $Timer

#func _ready():
	#set_seconds(5.0)
	
func start_timer() -> void:
	n_timer.start(seconds)

func _on_timer_timeout() -> void:
	self.queue_free()
