extends Node3D

var nodes : Array

@export
var MOVE_SPEED := 0.1

@export
var CAMERA_MARGIN := 5.0
var MARGIN := Vector3(CAMERA_MARGIN, CAMERA_MARGIN, CAMERA_MARGIN)

var minFOV := 15.0
var maxFOV := 90.0
var zoomSpeed := 1.0

@onready
var camera = $SmartCamera

var _min_bound := Vector3.ZERO
var _max_bound := Vector3.ZERO

@onready
var _screen_size = get_viewport().size


# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("FollowCamera")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
		
func _calculate_bounds() -> void:
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

func set_position_center() -> void:
	position = lerp(position, (_min_bound + _max_bound) / 2, MOVE_SPEED)
	
func set_fov() -> void:
	_screen_size = get_viewport().size
	
	var min_p_s = camera.unproject_position(_min_bound - MARGIN)
	var max_p_s = camera.unproject_position(_max_bound + MARGIN)
	var length = max_p_s.x - min_p_s.x
	var height = max_p_s.y - min_p_s.y
	
	var xScale = _screen_size.x / length
	var yScale = _screen_size.y / height
	
	var m = min(xScale, yScale)
	
	camera.fov = lerp(camera.fov, clamp(camera.fov/m, minFOV, maxFOV), zoomSpeed)
	

func _physics_process(delta):
	_calculate_bounds()
	set_position_center()
	set_fov()
#	set_zoom_level(delta)

