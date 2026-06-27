extends Node

const PORT = 8910
const DEFAULT_SERVER_IP = "127.0.0.1" # Localhost for testing on one PC
const MAX_PLAYERS = 2 # Exactly 2 players for your PvP mode

func host_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_PLAYERS)
	if error == OK:
		multiplayer.multiplayer_peer = peer
		print("Server hosted successfully!")
	else:
		print("Failed to host server: ", error)

func join_game(ip_address = DEFAULT_SERVER_IP):
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip_address, PORT)
	if error == OK:
		multiplayer.multiplayer_peer = peer
		print("Client joining...")
	else:
		print("Failed to join: ", error)
