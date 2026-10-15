extends Control

const PORT = 9999
@onready var ip_input = $CenterContainer/VBoxContainer/LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_failed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT)
	if error !=  OK:
		print('Failed to create server',error)
		return
	multiplayer.multiplayer_peer = peer
	print('Host server created.')


func _on_join_pressed() -> void:
	var ip = ip_input.text
	if ip == "":
		ip = "127.0.0.1"
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip,PORT)
	
	if error != OK:
		print('Error joining the server',error)
		
	multiplayer.multiplayer_peer = peer
	print('Connecting to the server.', ip)
	
func _on_connected_ok():
	print('Connected to the server.')
func _on_connected_failed():
	print('Failed to connect to the server.')
