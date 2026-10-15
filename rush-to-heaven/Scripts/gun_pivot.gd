extends Node3D

@onready var camera = $"../../SpringArm3D/Camera3D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_rotation.x = camera.global_rotation.x
	
	
	
