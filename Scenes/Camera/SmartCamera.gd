extends Node3D

var nodes : Array

@export var MOVE_SPEED := 0.1
@export var RESIZE_SPEED := 0.1
@export var ZOOM_SPEED : float = 0.1

@export var MARGIN := Vector4(3, 5, 5, 5)
@export var _minimum_distance := Vector2(20,20)

var minFOV : float = 1.0
var maxFOV : float = 100.0


@onready var camera = $SmartCamera

var _min_bound := Vector3.ZERO
var _max_bound := Vector3.ZERO

var _min_bound_curr := Vector3(INF, INF, INF)
var _max_bound_curr := Vector3(-INF, -INF, -INF)

var _min_bound_margin := Vector3.ZERO
var _max_bound_margin := Vector3.ZERO

@onready var _screen_size = get_viewport().size

var active := true

var debugger : Draw3D

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("FollowCamera")
	
	debugger = Draw3D.new()
	add_child(debugger)
	$"/root/Signals".connect("update_character", refresh_follow_camera)
	$"/root/Signals".connect("set_follow_camera_active", set_active)
	$"/root/Signals".connect("start_round", initialize)
	
func refresh_follow_camera() -> void:
	nodes = get_tree().get_nodes_in_group("FollowCamera")
	
func set_active(p_active: bool):
	self.active = p_active
		
func initialize() -> void:
	refresh_follow_camera()
	_call_without_lerp(_set_bounds, "RESIZE_SPEED")
	_call_without_lerp(_set_position_center, "MOVE_SPEED")
	_call_without_lerp(_set_fov, "ZOOM_SPEED")
	
func _call_without_lerp(callable : Callable, attr : String) -> void:
	var old_speed = get(attr)
	set(attr, 1)
	callable.call()
	set(attr, old_speed)
	
func _get_current_bounds() -> void:
	_min_bound_curr = Vector3(INF, INF, INF)
	_max_bound_curr = Vector3(-INF, -INF, -INF)
	
	for node in nodes:
		if not node:
			continue
		if node.is_visible():
			_min_bound_curr.x = min(_min_bound_curr.x, node.global_position.x)
			_min_bound_curr.y = min(_min_bound_curr.y, node.global_position.y)
			_min_bound_curr.z = min(_min_bound_curr.z, node.global_position.z)

			_max_bound_curr.x = max(_max_bound_curr.x, node.global_position.x)
			_max_bound_curr.y = max(_max_bound_curr.y, node.global_position.y)
			_max_bound_curr.z = max(_max_bound_curr.z, node.global_position.z)
			
func _set_bounds() -> void:
	_get_current_bounds()
	_min_bound = lerp(_min_bound, _min_bound_curr, RESIZE_SPEED)
	_max_bound = lerp(_max_bound, _max_bound_curr, RESIZE_SPEED)
	_calculate_minimum()
	_calculate_margin()

func _calculate_minimum():
	var distance := _max_bound - _min_bound
	var dims := Vector2(distance.x, distance.z)
	var offset := 0.0
	if dims.x < _minimum_distance.x:
		offset = (_minimum_distance.x-dims.x) /2 
		_min_bound.x -= offset
		_max_bound.x += offset
	if dims.y < _minimum_distance.y:
		offset = (_minimum_distance.y-dims.y) / 2
		_min_bound.z -= offset
		_max_bound.z += offset
		
func _calculate_margin() -> void:
	_min_bound_margin = _min_bound - Vector3(MARGIN.w, 0, MARGIN.x)
	_max_bound_margin = _max_bound + Vector3(MARGIN.y, 0, MARGIN.z)
	
func _set_position_center() -> void:
	var center : Vector3 = (_min_bound + _max_bound) / 2
	center.y = 0
	
	position.x = lerp(position.x, center.x, MOVE_SPEED)
	position.z = lerp(position.z, center.z, MOVE_SPEED)
	
func _set_fov() -> void:
	var min_p_s : Vector2 = camera.unproject_position(_min_bound_margin)
	var max_p_s : Vector2 = camera.unproject_position(_max_bound_margin) 
	
	var r := Rect2()
	r = r.expand(min_p_s)
	r = r.expand(max_p_s)
	
	#var base_screen_size = Vector2(1920, 1080)
	
	var z = max(r.size.x / _screen_size.x, r.size.y / _screen_size.y)
	
	camera.fov = lerp(camera.fov, clamp(camera.fov * z, minFOV, maxFOV), ZOOM_SPEED)
	
	
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

func _physics_process(_delta):
	if not active: 
		return
	_screen_size = get_viewport().size
	
	_set_bounds()
	_set_position_center()
	_set_fov()

