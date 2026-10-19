extends CharacterBody3D

@export var speed: float = 150.0
var target: Vector3

func launch(start_pos:Vector3, end_pos:Vector3) -> void:
	if start_pos.distance_to(end_pos) < 0.01:
		queue_free()
		return
	global_position = start_pos
	target = end_pos
	var direction = start_pos.direction_to(end_pos).normalized()
	velocity = direction * speed
	look_at(end_pos)

func _physics_process(delta: float) -> void:
	if global_position.distance_to(target) <= velocity.length() * delta:
		queue_free()
		return 
	move_and_slide()
