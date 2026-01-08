extends Control

# Virtual Joystick untuk Android/Touch devices

@export var joystick_radius: float = 60.0
@export var stick_radius: float = 25.0
@export var deadzone: float = 0.2

var is_pressed: bool = false
var touch_index: int = -1
var joystick_center: Vector2 = Vector2.ZERO
var stick_position: Vector2 = Vector2.ZERO
var output: Vector2 = Vector2.ZERO

# Colors
var base_color: Color = Color(0.5, 0.5, 0.5, 0.5)
var stick_color: Color = Color(0.8, 0.8, 0.8, 0.8)

func _ready():
	# Set joystick position di kiri bawah layar
	var viewport_size = get_viewport().get_visible_rect().size
	position = Vector2(100, viewport_size.y - 100)
	joystick_center = Vector2.ZERO
	stick_position = Vector2.ZERO
	
	# Set size untuk area input
	custom_minimum_size = Vector2(joystick_radius * 2, joystick_radius * 2)
	
	# Debug print
	print("Virtual Joystick initialized at: ", position)
	print("Joystick global position: ", global_position)

func _process(_delta):
	# Debug: print output jika ada input
	if output != Vector2.ZERO:
		print("Joystick output: ", output)

func _draw():
	# Draw base (lingkaran luar)
	draw_circle(joystick_center, joystick_radius, base_color)
	
	# Draw stick (lingkaran dalam yang bisa digerakkan)
	draw_circle(stick_position, stick_radius, stick_color)

func _input(event):
	# Handle touch input (untuk mobile)
	if event is InputEventScreenTouch:
		if event.pressed:
			# Check if touch is within joystick area
			var touch_pos = event.position - global_position
			if touch_pos.distance_to(joystick_center) <= joystick_radius:
				is_pressed = true
				touch_index = event.index
				_update_stick_position(touch_pos)
		else:
			# Release touch
			if event.index == touch_index:
				_reset_joystick()
	
	elif event is InputEventScreenDrag:
		# Drag stick
		if event.index == touch_index and is_pressed:
			var touch_pos = event.position - global_position
			_update_stick_position(touch_pos)
	
	# Handle mouse input (untuk testing di PC)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var mouse_pos = event.position - global_position
				if mouse_pos.distance_to(joystick_center) <= joystick_radius:
					is_pressed = true
					_update_stick_position(mouse_pos)
			else:
				_reset_joystick()
	
	elif event is InputEventMouseMotion:
		if is_pressed and touch_index == -1:  # Mouse mode
			var mouse_pos = event.position - global_position
			_update_stick_position(mouse_pos)

func _update_stick_position(touch_pos: Vector2):
	# Calculate stick position relative to center
	var direction = touch_pos - joystick_center
	var distance = direction.length()
	
	# Limit stick movement to joystick radius
	if distance > joystick_radius:
		direction = direction.normalized() * joystick_radius
		distance = joystick_radius
	
	stick_position = joystick_center + direction
	
	# Calculate output vector (-1 to 1)
	output = direction / joystick_radius
	
	# Apply deadzone
	if output.length() < deadzone:
		output = Vector2.ZERO
	
	queue_redraw()

func _reset_joystick():
	is_pressed = false
	touch_index = -1
	stick_position = joystick_center
	output = Vector2.ZERO
	queue_redraw()

func get_output() -> Vector2:
	return output
