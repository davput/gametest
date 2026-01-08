extends CharacterBody2D

# Player dengan boundary check
# Alternatif: clamp posisi player agar tidak keluar map

@export var move_speed: float = 150.0
@export var acceleration: float = 1000.0
@export var friction: float = 1200.0

# Map boundaries
@export var map_min: Vector2 = Vector2.ZERO
@export var map_max: Vector2 = Vector2(2000, 2000)
@export var enable_boundary: bool = true

var virtual_joystick = null
var input_vector: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN

func _ready():
	virtual_joystick = _find_virtual_joystick()
	if virtual_joystick != null:
		print("Player: Virtual joystick found!")
	else:
		print("Player: Virtual joystick NOT found - using keyboard only")

func _find_virtual_joystick():
	var root = get_tree().root
	return _search_node(root, "VirtualJoystick")

func _search_node(node: Node, node_name: String):
	if node.name == node_name:
		return node
	for child in node.get_children():
		var result = _search_node(child, node_name)
		if result != null:
			return result
	return null

func _physics_process(delta):
	# Get input
	input_vector = Vector2.ZERO
	var kb_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var joystick_input = Vector2.ZERO
	if virtual_joystick != null:
		joystick_input = virtual_joystick.get_output()
	
	if kb_input.length() > 0.1:
		input_vector = kb_input
	else:
		input_vector = joystick_input
	
	# Movement
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * move_speed, acceleration * delta)
		last_direction = input_vector
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	# Move
	move_and_slide()
	
	# Clamp position to map boundaries
	if enable_boundary:
		position.x = clamp(position.x, map_min.x, map_max.x)
		position.y = clamp(position.y, map_min.y, map_max.y)
