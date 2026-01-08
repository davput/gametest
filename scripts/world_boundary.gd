extends Node2D

# Script untuk setup world boundary
# Attach ke World node untuk auto-setup camera limits

@export var map_width: float = 2000.0
@export var map_height: float = 2000.0
@export var map_offset: Vector2 = Vector2.ZERO

func _ready():
	# Cari camera di scene
	var camera = find_camera(self)
	if camera:
		setup_camera_limits(camera)
	else:
		print("Warning: Camera not found in scene!")

func find_camera(node: Node) -> Camera2D:
	# Cari Camera2D di scene tree
	if node is Camera2D:
		return node
	for child in node.get_children():
		var result = find_camera(child)
		if result:
			return result
	return null

func setup_camera_limits(camera: Camera2D):
	# Set camera limits
	camera.limit_left = int(map_offset.x)
	camera.limit_top = int(map_offset.y)
	camera.limit_right = int(map_offset.x + map_width)
	camera.limit_bottom = int(map_offset.y + map_height)
	camera.limit_smoothed = true
	
	print("Camera limits configured:")
	print("  Map size: ", map_width, " x ", map_height)
	print("  Limits: ", camera.limit_left, ", ", camera.limit_top, " to ", camera.limit_right, ", ", camera.limit_bottom)
