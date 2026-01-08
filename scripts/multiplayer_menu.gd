extends Control

# Multiplayer menu untuk host atau join game

@onready var name_input = $VBoxContainer/NameInput
@onready var ip_input = $VBoxContainer/IPInput
@onready var host_button = $VBoxContainer/HostButton
@onready var join_button = $VBoxContainer/JoinButton
@onready var status_label = $VBoxContainer/StatusLabel
@onready var info_label = $VBoxContainer/InfoLabel

var network_manager: Node

func _ready():
	# Get network manager
	network_manager = get_node("/root/NetworkManager")
	
	# Connect signals
	host_button.pressed.connect(_on_host_pressed)
	join_button.pressed.connect(_on_join_pressed)
	network_manager.player_connected.connect(_on_player_connected)
	network_manager.server_disconnected.connect(_on_server_disconnected)
	
	# Set default name
	name_input.text = "Player" + str(randi() % 1000)
	
	# Get local IP
	var local_ip = get_local_ip()
	info_label.text = "Your IP: " + local_ip + "\nHost: Click 'Host Game'\nJoin: Enter host's IP"

func _on_host_pressed():
	var player_name = name_input.text
	if player_name.is_empty():
		player_name = "Host"
	
	var error = network_manager.create_server(player_name)
	if error == OK:
		status_label.text = "Status: Hosting on " + get_local_ip()
		status_label.add_theme_color_override("font_color", Color.GREEN)
		
		# Start game
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/world.tscn")
	else:
		status_label.text = "Status: Failed to host"
		status_label.add_theme_color_override("font_color", Color.RED)

func _on_join_pressed():
	var player_name = name_input.text
	if player_name.is_empty():
		player_name = "Client"
	
	var ip = ip_input.text
	if ip.is_empty():
		status_label.text = "Status: Enter IP address"
		status_label.add_theme_color_override("font_color", Color.RED)
		return
	
	status_label.text = "Status: Connecting..."
	status_label.add_theme_color_override("font_color", Color.YELLOW)
	
	var error = network_manager.join_server(ip, player_name)
	if error == OK:
		# Wait for connection
		await get_tree().create_timer(2.0).timeout
		if multiplayer.multiplayer_peer and multiplayer.multiplayer_peer.get_connection_status() == MultiplayerPeer.CONNECTION_CONNECTED:
			get_tree().change_scene_to_file("res://scenes/world.tscn")
		else:
			status_label.text = "Status: Connection failed"
			status_label.add_theme_color_override("font_color", Color.RED)
	else:
		status_label.text = "Status: Failed to connect"
		status_label.add_theme_color_override("font_color", Color.RED)

func _on_player_connected(peer_id: int, player_info: Dictionary):
	print("Player joined: ", player_info.name)

func _on_server_disconnected():
	status_label.text = "Status: Server disconnected"
	status_label.add_theme_color_override("font_color", Color.RED)

func get_local_ip() -> String:
	# Get local IP address
	var addresses = IP.get_local_addresses()
	for address in addresses:
		# Filter untuk IPv4 dan bukan localhost
		if address.begins_with("192.168.") or address.begins_with("10.") or address.begins_with("172."):
			return address
	return "Unknown"
