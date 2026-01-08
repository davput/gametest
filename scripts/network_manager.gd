extends Node

# Network Manager untuk multiplayer
# Mengatur koneksi P2P antara host dan client

signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected

const PORT = 7777
const MAX_PLAYERS = 4

var peer = ENetMultiplayerPeer.new()
var players = {}
var player_info = {"name": "Player"}

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

# Host game (jadi server)
func create_server(player_name: String) -> int:
	player_info.name = player_name
	
	var error = peer.create_server(PORT, MAX_PLAYERS)
	if error != OK:
		print("Error creating server: ", error)
		return error
	
	multiplayer.multiplayer_peer = peer
	
	# Add host sebagai player
	players[1] = player_info
	print("Server created on port ", PORT)
	print("Host player: ", player_info)
	
	return OK

# Join game (jadi client)
func join_server(address: String, player_name: String) -> int:
	player_info.name = player_name
	
	var error = peer.create_client(address, PORT)
	if error != OK:
		print("Error creating client: ", error)
		return error
	
	multiplayer.multiplayer_peer = peer
	print("Connecting to server: ", address)
	
	return OK

# Disconnect dari network
func disconnect_from_game():
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
		multiplayer.multiplayer_peer = null
	players.clear()
	print("Disconnected from game")

# Callbacks
func _on_player_connected(id: int):
	print("Player connected: ", id)
	
	# Jika kita host, kirim info semua player ke player baru
	if multiplayer.is_server():
		# Kirim info player yang sudah ada
		for peer_id in players:
			rpc_id(id, "register_player", peer_id, players[peer_id])

func _on_player_disconnected(id: int):
	print("Player disconnected: ", id)
	players.erase(id)
	player_disconnected.emit(id)

func _on_connected_to_server():
	print("Successfully connected to server")
	# Kirim info player kita ke server
	rpc_id(1, "register_player", multiplayer.get_unique_id(), player_info)

func _on_connection_failed():
	print("Connection failed")
	multiplayer.multiplayer_peer = null

func _on_server_disconnected():
	print("Server disconnected")
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()

# RPC untuk register player
@rpc("any_peer", "reliable")
func register_player(id: int, info: Dictionary):
	players[id] = info
	print("Player registered: ", id, " - ", info)
	player_connected.emit(id, info)
	
	# Broadcast ke semua player (jika kita host)
	if multiplayer.is_server():
		for peer_id in multiplayer.get_peers():
			if peer_id != id:
				rpc_id(peer_id, "register_player", id, info)

# Helper functions
func is_host() -> bool:
	return multiplayer.is_server()

func get_player_count() -> int:
	return players.size()

func get_local_player_id() -> int:
	return multiplayer.get_unique_id()
