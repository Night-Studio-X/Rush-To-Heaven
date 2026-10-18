extends Node3D

const PLAYER_SCENE = preload('res://Scenes/wz_551.tscn')
@onready var players = $Players

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not multiplayer.is_server():
		return 
	multiplayer.peer_connected.connect(_spawn_player)
	_spawn_player(1)

func _spawn_player(id: int):
	var player = PLAYER_SCENE.instantiate()
	player.name = str(id)
	player.position = Vector3(0, 2, 0)
	players.add_child(player)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
