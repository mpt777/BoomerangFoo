extends Area3D

class_name ItemDropComponent

var is_active : bool = false:
	set(value):
		is_active = value
		set_activity()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	pass # Replace with function body.

func _on_area_entered(area):
	pass # Replace with function body.

func set_activity() -> void:
	set_deferred("monitorable", self.is_active)
	set_deferred("monitoring", self.is_active)

func activate() -> void:
	self.is_active = true

func deactivate() -> void:
	self.is_active = false

func start_timer():
	$Timer.start()

func _on_timer_timeout():
	self.activate()
