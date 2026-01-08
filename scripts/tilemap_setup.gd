extends TileMapLayer

# Script untuk setup tilemap secara procedural
# Bisa dihapus setelah tilemap sudah di-design manual

func _ready():
	# Generate simple grass tiles
	generate_grass_area(0, 0, 30, 20)

func generate_grass_area(start_x: int, start_y: int, width: int, height: int):
	# Fill area dengan grass tiles
	for x in range(start_x, start_x + width):
		for y in range(start_y, start_y + height):
			# Set tile di posisi (x, y)
			# Source ID 0, Atlas coords (0, 0), alternative tile 0
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)
