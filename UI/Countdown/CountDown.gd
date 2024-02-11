extends Control
class_name CountDown

@export var messages : Array = [
	"Ready", "Steady", "Bash!"
]

signal finished

var index := 0

func start():
	if index >= len(messages):
		finished.emit()
		queue_free()
		return
	$Label.text = messages[index]
	$Timer.start()
	
func _on_timer_timeout():
	index += 1
	start()
	
