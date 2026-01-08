extends CharacterBody2D

# Player dengan fitur jump/hop untuk top-down game

@export var move_speed: float = 150.0
@export var acceleration: float = 1000.0
@export var friction: float = 1200.0

# Jump settings
@export var jump_height: float = 30.0  # Tinggi hop (pixel)
@export var jump_duration: float = 0.4  # Durasi hop (detik)
@export var jump_cooldown: float = 0.5  # Cooldown antar jump

# Map boundaries
@export var map_min: Vector2 = Vector2.ZERO
@export var map_max: Vector2 = Vector2(2000, 2000)
@export var enable_boundary: bool = true

var virtual_joystick = null
var input_vector: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN

# Jump state
var is_jumping: bool = false
var jump_timer: float = 0.0
var cooldown_timer: float = 0.0
var jump_offset: float = 0.0

@onready var sprite = $Sprite2D

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
	# Update cooldown
	if cooldown_timer > 0:
		cooldown_timer -= delta
	
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
	
	# Check jump input
	if Input.is_action_just_pressed("jump") and not is_jumping and cooldown_timer <= 0:
		start_jump()
	
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
	
	# Update jump animation
	update_jump(delta)

func start_jump():
	is_jumping = true
	jump_timer = 0.0
	print("Jump!")

func update_jump(delta):
	if not is_jumping:
		return
	
	jump_timer += delta
	
	# Calculate jump arc (parabola)
	var progress = jump_timer / jump_duration
	if progress >= 1.0:
		# Jump finished
		is_jumping = false
		jump_offset = 0.0
		cooldown_timer = jump_cooldown
		if sprite:
			sprite.position.y = 0
	else:
		# Jump arc: -4 * height * (progress^2 - progress)
		jump_offset = -4.0 * jump_height * (progress * progress - progress)
		if sprite:
			sprite.position.y = jump_offset
			# Scale effect (optional - karakter sedikit membesar saat di udara)
			var scale_factor = 1.0 + (abs(jump_offset) / jump_height) * 0.1
			sprite.scale = Vector2(scale_factor, scale_factor)

func _process(_delta):
	# Visual feedback saat cooldown
	if sprite and cooldown_timer > 0:
		# Blink effect atau color modulation (optional)
		pass
