extends Button

# Virtual jump button untuk mobile
# Button akan trigger input action "jump"

func _ready():
	# Setup button
	text = "Jump"
	
	# Position di kanan bawah
	var viewport_size = get_viewport_rect().size
	position = Vector2(viewport_size.x - 120, viewport_size.y - 120)
	size = Vector2(100, 100)
	
	# Style
	modulate = Color(1, 1, 1, 0.7)
	
	# Connect signal
	pressed.connect(_on_pressed)
	
	print("Jump button initialized at: ", position)

func _on_pressed():
	# Trigger jump action
	Input.action_press("jump")
	print("Jump button pressed!")
	
	# Release after short delay
	await get_tree().create_timer(0.1).timeout
	Input.action_release("jump")
