extends Camera3D

var nodes : Array

@export
var min_zoom := 1.0

@export
var max_zoom := 2.0

@export
var MOVE_SPEED := 0.1

@export
var CAMERA_MARGIN := 5.0

var minFOV = 30
var maxFOV = 90
var zoomSpeed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("FollowCamera")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _get_average_position() -> Vector3:
	var avg_pos : Vector3 = Vector3.ZERO
	for node in nodes:
		avg_pos += node.global_position
	avg_pos /= len(nodes)
	return avg_pos

func set_zoom_level(delta):
	var max_distance : float = 0.0
	for node in nodes:
		if node.is_visible():
			for node2 in nodes:
				var distance = abs(node2.global_position.distance_to(node.global_position))
				if distance > max_distance:
					max_distance = distance
	fov = lerp(fov, max_distance*2, MOVE_SPEED)
	fov = clamp(fov, 30, 90)
		

func set_zoom_level_old(delta):
	var minPoint = Vector3(INF, INF, INF)
	var maxPoint = Vector3(-INF, -INF, -INF)
	

	for node in nodes:
		if node.is_visible():
			minPoint.x = min(minPoint.x, node.global_position.x)
			minPoint.y = min(minPoint.y, node.global_position.y)
			minPoint.z = min(minPoint.z, node.global_position.z)

			maxPoint.x = max(maxPoint.x, node.global_position.x )
			maxPoint.y = max(maxPoint.y, node.global_position.y )
			maxPoint.z = max(maxPoint.z, node.global_position.z )
			
	var center = (minPoint + maxPoint) / 2

	position = lerp(position, center, MOVE_SPEED)
	
	
func _physics_process(delta):

	set_zoom_level_old(delta)
	set_zoom_level(delta)
	position.y = 30
#	print(position)
#	camera.offset = (p1.position + p2.position) / 2
#	camera.rotation_degrees = rad2deg((p2.position - p1.position).angle())
#	var zoom = (p1.position - p2.position).length() / get_viewport_rect().size.x * k
#	camera.zoom = Vector2(zoom, zoom)

