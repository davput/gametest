extends CharacterBody2D

# Player dengan multiplayer support
# Sync posisi dan movement ke semua player

@export var move_speed: float = 150.0
@export var acceleration: float = 1000.0
@export var friction: float = 1200.0

# Jump settings
@export var jump_height: float = 30.0
@export var jump_duration: float = 0.4
@export var jump_cooldown: float = 0.5

var virtual_joystick = null
var input_vector: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN

# Jump state
var is_jumping: bool = false
var jump_timer: float = 0.0
var cooldown_timer: float = 0.0
var jump_offset: float = 0.0

# Multiplayer
var player_id: int = 1
var is_local_player: bool = true

@onready var sprite = $Sprite2D
@onready var camera = $Camera2D
@onready var label = $Label

func _ready():
	# Setup multiplayer
	player_id = int(str(name))
	is_local_player = (player_id == multiplayer.get_unique_id())
	
	# Hanya local player yang punya camera dan input
	if camera:
		camera.enabled = is_local_player
	
	# Setup label nama
	if label:
		label.text = "Player " + str(player_id)
		label.position = Vector2(-30, -60)
	
	# Setup joystick hanya untuk local player
	if is_local_player:
		virtual_joystick = _find_virtual_joystick()
		if virtual_joystick:
			print("Player: Virtual joystick found!")
	
	print("Player initialized: ", player_id, " | Local: ", is_local_player)

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
	# Hanya local player yang bisa kontrol
	if not is_local_player:
		return
	
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
		rpc("sync_jump")  # Sync jump ke player lain
	
	# Movement
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * move_speed, acceleration * delta)
		last_direction = input_vector
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	# Move
	move_and_slide()
	
	# Sync position ke player lain
	if multiplayer.is_server():
		rpc("sync_position", position, velocity)
	else:
		rpc_id(1, "sync_position", position, velocity)
	
	# Update jump animation
	update_jump(delta)

func start_jump():
	is_jumping = true
	jump_timer = 0.0

func update_jump(delta):
	if not is_jumping:
		return
	
	jump_timer += delta
	var progress = jump_timer / jump_duration
	
	if progress >= 1.0:
		is_jumping = false
		jump_offset = 0.0
		cooldown_timer = jump_cooldown
		if sprite:
			sprite.position.y = 0
			sprite.scale = Vector2.ONE
	else:
		jump_offset = -4.0 * jump_height * (progress * progress - progress)
		if sprite:
			sprite.position.y = jump_offset
			var scale_factor = 1.0 + (abs(jump_offset) / jump_height) * 0.1
			sprite.scale = Vector2(scale_factor, scale_factor)

# RPC untuk sync posisi
@rpc("any_peer", "unreliable")
func sync_position(pos: Vector2, vel: Vector2):
	if is_local_player:
		return
	position = pos
	velocity = vel

# RPC untuk sync jump
@rpc("any_peer", "reliable")
func sync_jump():
	if is_local_player:
		return
	start_jump()
