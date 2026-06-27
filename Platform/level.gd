extends Node2D

@onready var players_container = $Players
var player_scene = preload("res://Player/player.tscn")

func _ready():
	# Listen for when a new player connects to the LAN
	multiplayer.peer_connected.connect(_add_player)

func _on_host_pressed():
	NetworkManager.host_game()
	$CanvasLayer.hide() # Hide the menu
	_add_player(multiplayer.get_unique_id()) # Spawn the host player

func _on_join_pressed():
	NetworkManager.join_game()
	$CanvasLayer.hide()
	
func _add_player(peer_id: int):
	# Only the server has the authority to spawn players in Godot 4
	if not multiplayer.is_server():
		return
		
	var player_instance = player_scene.instantiate()
	player_instance.name = str(peer_id) # Name MUST be the peer ID for authority to work
	players_container.add_child(player_instance)
