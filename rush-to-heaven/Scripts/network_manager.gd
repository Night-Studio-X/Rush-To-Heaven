extends Node

const PORT = 9999

func host() -> Error:
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT)
	if error != OK:
		return error
	multiplayer.multiplayer_peer = peer
	return OK
	
func join(ip:String) -> Error:
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip,PORT)
	if error != OK:
		return error
	multiplayer.multiplayer_peer = peer
	return OK
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
