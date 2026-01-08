extends Camera2D

# Camera dengan limit agar tidak keluar dari map
# Attach script ini ke Camera2D di player

# Ukuran map/background (sesuaikan dengan background kamu)
@export var map_width: float = 2000.0
@export var map_height: float = 2000.0
@export var map_offset: Vector2 = Vector2.ZERO  # Offset jika map tidak di (0,0)

func _ready():
	setup_camera_limits()

func setup_camera_limits():
	# Set camera limits berdasarkan ukuran map
	limit_left = int(map_offset.x)
	limit_top = int(map_offset.y)
	limit_right = int(map_offset.x + map_width)
	limit_bottom = int(map_offset.y + map_height)
	
	# Enable limit smoothing
	limit_smoothed = true
	
	print("Camera limits set:")
	print("  Left: ", limit_left)
	print("  Top: ", limit_top)
	print("  Right: ", limit_right)
	print("  Bottom: ", limit_bottom)
