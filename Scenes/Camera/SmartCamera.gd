extends Node3D

var nodes : Array

@export
var MOVE_SPEED := 0.1

@export
var MARGIN := Vector2(5, 5)

var minFOV : float = 1.0
var maxFOV : float = 60.0
var zoomSpeed : float = 1.0

@onready
var camera = $SmartCamera

var _min_bound := Vector3.ZERO
var _max_bound := Vector3.ZERO

var _min_bound_margin := Vector3.ZERO
var _max_bound_margin := Vector3.ZERO

@onready
var _screen_size = get_viewport().size

var debugger : Draw3D

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("FollowCamera")
	
	debugger = Draw3D.new()
	add_child(debugger)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
		
func _calculate_bounds() -> void:
	_screen_size = get_viewport().size
	_min_bound = Vector3(INF, INF, INF)
	_max_bound = Vector3(-INF, -INF, -INF)
	
	for node in nodes:
		if node.is_visible():
			_min_bound.x = min(_min_bound.x, node.global_position.x)
			_min_bound.y = min(_min_bound.y, node.global_position.y)
			_min_bound.z = min(_min_bound.z, node.global_position.z)

			_max_bound.x = max(_max_bound.x, node.global_position.x)
			_max_bound.y = max(_max_bound.y, node.global_position.y)
			_max_bound.z = max(_max_bound.z, node.global_position.z)
			
	_min_bound_margin = _min_bound - Vector3(MARGIN.x, 0, MARGIN.y)
	_max_bound_margin = _max_bound + Vector3(MARGIN.x, 0, MARGIN.y)
	
func set_position_center() -> void:
	var center : Vector3 = (_min_bound + _max_bound) / 2
	center.y = 0
	
	var world_center : Vector2 = camera.unproject_position(center)
	var screen_center := Vector2(_screen_size/2)
	
	var difference = world_center - screen_center

	position.x = lerp(position.x, position.x + (difference.x / _screen_size.x * 50), MOVE_SPEED)
	position.z = lerp(position.z, position.z + (difference.y / _screen_size.y * 50), MOVE_SPEED)
	
func set_fov() -> void:
	
	var min_p_s : Vector2 = camera.unproject_position(_min_bound_margin)
	var max_p_s : Vector2 = camera.unproject_position(_max_bound_margin) 
	
	var r := Rect2()
	r = r.expand(min_p_s)
	r = r.expand(max_p_s)
	
	var z
	if r.size.x > r.size.y * _screen_size.aspect():
		z = r.size.x / _screen_size.x
	else:
		z = r.size.y / _screen_size.y
	
	camera.fov = lerp(camera.fov, clamp(camera.fov * z, minFOV, maxFOV), zoomSpeed)
	
	
func debug() -> void:
	debugger.reset()

	var pointA = Vector3(_min_bound.x, 1, _min_bound.z)
	var pointB = Vector3(_min_bound.x, 1, _max_bound.z)
	var pointC = Vector3(_max_bound.x, 1, _min_bound.z)
	var pointD = Vector3(_max_bound.x, 1, _max_bound.z)

	debugger.add_point(pointA)
	debugger.add_point(pointC)
	debugger.add_point(pointD)
	debugger.add_point(pointB)
	debugger.add_point(pointA)
	debugger.add_point(pointC)
	
	pointA = Vector3(_min_bound_margin.x, 1, _min_bound_margin.z)
	pointB = Vector3(_min_bound_margin.x, 1, _max_bound_margin.z)
	pointC = Vector3(_max_bound_margin.x, 1, _min_bound_margin.z)
	pointD = Vector3(_max_bound_margin.x, 1, _max_bound_margin.z)

	debugger.add_point(pointA)
	debugger.add_point(pointC)
	debugger.add_point(pointD)
	debugger.add_point(pointB)
	debugger.add_point(pointA)
	debugger.add_point(pointC)
	
	debugger.add_point((_min_bound + _max_bound) / 2)
	debugger.add_point((_min_bound + _max_bound) / 2)
	
	debugger.draw_line()

func _physics_process(delta):
	return
	_calculate_bounds()
#	debug()
	set_position_center()
	set_fov()

