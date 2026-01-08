extends CharacterBody2D

# Player movement settings
@export var move_speed: float = 150.0
@export var acceleration: float = 1000.0
@export var friction: float = 1200.0

# Reference ke virtual joystick
@onready var virtual_joystick = get_node_or_null("/root/World/UI/VirtualJoystick")

# Input vector
var input_vector: Vector2 = Vector2.ZERO

# Animation direction (untuk nanti)
var last_direction: Vector2 = Vector2.DOWN

func _ready():
	pass

func _physics_process(delta):
	# Get input dari keyboard, gamepad, atau virtual joystick
	input_vector = Vector2.ZERO
	
	# Keyboard/Gamepad input
	var kb_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Virtual joystick input (untuk mobile)
	var joystick_input = Vector2.ZERO
	if virtual_joystick != null:
		joystick_input = virtual_joystick.get_output()
	
	# Gunakan input yang lebih kuat (prioritas keyboard/gamepad)
	if kb_input.length() > 0.1:
		input_vector = kb_input
	else:
		input_vector = joystick_input
	
	# Smooth movement dengan acceleration dan friction
	if input_vector != Vector2.ZERO:
		# Normalize untuk movement yang konsisten di semua arah
		input_vector = input_vector.normalized()
		
		# Apply acceleration
		velocity = velocity.move_toward(input_vector * move_speed, acceleration * delta)
		
		# Update last direction untuk animasi
		last_direction = input_vector
	else:
		# Apply friction saat tidak ada input
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	# Move character
	move_and_slide()
