extends CharacterBody2D

# Player dengan platform jump (untuk side-view game)
# Pakai ini jika game kamu side-view seperti Mario

@export var move_speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 980.0

var virtual_joystick = null

func _ready():
	virtual_joystick = _find_virtual_joystick()

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
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		print("Jump!")
	
	# Horizontal movement
	var direction = 0.0
	var kb_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var joystick_input = Vector2.ZERO
	if virtual_joystick != null:
		joystick_input = virtual_joystick.get_output()
	
	if kb_input.length() > 0.1:
		direction = kb_input.x
	else:
		direction = joystick_input.x
	
	velocity.x = direction * move_speed
	
	move_and_slide()
