extends Node2D

# World dengan multiplayer support
# Spawn player untuk setiap peer yang connect

const PLAYER_SCENE = preload("res://scenes/player_multiplayer.tscn")

var spawn_positions = [
	Vector2(200, 300),
	Vector2(400, 300),
	Vector2(600, 300),
	Vector2(800, 300)
]

func _ready():
	# Connect network signals
	var network_manager = get_node("/root/NetworkManager")
	network_manager.player_connected.connect(_on_player_connected)
	network_manager.player_disconnected.connect(_on_player_disconnected)
	
	# Spawn players yang sudah ada
	if multiplayer.is_server():
		# Spawn host player
		spawn_player(1)
		
		# Spawn players yang sudah connect
		for peer_id in multiplayer.get_peers():
			spawn_player(peer_id)
	else:
		# Client: spawn semua player
		var network = get_node("/root/NetworkManager")
		for peer_id in network.players:
			spawn_player(peer_id)

func _on_player_connected(peer_id: int, player_info: Dictionary):
	print("Spawning player: ", peer_id)
	spawn_player(peer_id)

func _on_player_disconnected(peer_id: int):
	print("Removing player: ", peer_id)
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()

func spawn_player(peer_id: int):
	# Check if player already exists
	if has_node(str(peer_id)):
		return
	
	# Create player instance
	var player = PLAYER_SCENE.instantiate()
	player.name = str(peer_id)
	
	# Set spawn position
	var spawn_index = (peer_id - 1) % spawn_positions.size()
	player.position = spawn_positions[spawn_index]
	
	add_child(player)
	print("Player spawned: ", peer_id, " at ", player.position)
