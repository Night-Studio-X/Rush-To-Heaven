extends Control


@onready var ip_input = $CenterContainer/VBoxContainer/LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_failed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_pressed() -> void:
	var error = NetworkManager.host()
	if error != OK:
		print('There is an error creating server',error)
		return 
	print('Host server created.')
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_join_pressed() -> void:
	var ip = ip_input.text
	if ip == "":
		ip = "127.0.0.1"
	var error = NetworkManager.join(ip)
	if error != OK:
		print('Error joining the server.',error)
		return 
	print('Connecting to the server.', ip)
	
func _on_connected_ok():
	print('Connected to the server.')
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
func _on_connected_failed():
	print('Failed to connect to the server.')
