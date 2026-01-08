extends CharacterBody2D

# Simple player movement untuk testing
@export var speed: float = 200.0

func _physics_process(_delta):
	# Get input
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Set velocity
	velocity = direction * speed
	
	# Move
	move_and_slide()
	
	# Debug
	if direction != Vector2.ZERO:
		print("Input detected: ", direction, " | Velocity: ", velocity)
