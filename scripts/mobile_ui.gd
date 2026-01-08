extends CanvasLayer

# Mobile UI manager
# Mengatur posisi dan visibility virtual controls

@onready var joystick = $VirtualJoystick
@onready var jump_button = $JumpButton

func _ready():
	setup_ui()

func setup_ui():
	var viewport_size = get_viewport().get_visible_rect().size
	
	# Setup jump button position (kanan bawah)
	if jump_button:
		jump_button.position = Vector2(viewport_size.x - 120, viewport_size.y - 120)
		jump_button.size = Vector2(100, 100)
		jump_button.text = "Jump"
		
		# Style button
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.2, 0.6, 1.0, 0.6)  # Biru transparan
		style.corner_radius_top_left = 50
		style.corner_radius_top_right = 50
		style.corner_radius_bottom_left = 50
		style.corner_radius_bottom_right = 50
		jump_button.add_theme_stylebox_override("normal", style)
		
		# Hover style
		var style_hover = StyleBoxFlat.new()
		style_hover.bg_color = Color(0.3, 0.7, 1.0, 0.8)
		style_hover.corner_radius_top_left = 50
		style_hover.corner_radius_top_right = 50
		style_hover.corner_radius_bottom_left = 50
		style_hover.corner_radius_bottom_right = 50
		jump_button.add_theme_stylebox_override("hover", style_hover)
		
		# Pressed style
		var style_pressed = StyleBoxFlat.new()
		style_pressed.bg_color = Color(0.1, 0.5, 0.9, 0.9)
		style_pressed.corner_radius_top_left = 50
		style_pressed.corner_radius_top_right = 50
		style_pressed.corner_radius_bottom_left = 50
		style_pressed.corner_radius_bottom_right = 50
		jump_button.add_theme_stylebox_override("pressed", style_pressed)
		
		# Connect signal
		jump_button.pressed.connect(_on_jump_pressed)
		
		print("Jump button setup at: ", jump_button.position)

func _on_jump_pressed():
	# Trigger jump action
	Input.action_press("jump")
	print("Jump!")
	
	# Release after short delay
	await get_tree().create_timer(0.1).timeout
	Input.action_release("jump")
