extends Node

const FIRE_INTERVAL:float = 1
var last_shot_time:float = 0

@export var muzzle: Marker3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	if Input.is_action_pressed('fire'):
		print('Fire held on peer ',multiplayer.get_unique_id())
		request_fire.rpc_id(1)
		
@rpc("any_peer",'call_local',"unreliable")
func request_fire()->void:
	if not multiplayer.is_server():
		return
	var now := Time.get_ticks_msec() / 1000
	if now - last_shot_time < FIRE_INTERVAL:
		return
	last_shot_time = now
	print("server: fire request for car ",get_parent().name)
	_fire_ray()
	
func _fire_ray() -> void:
	var origin := muzzle.global_position
	var direction := -muzzle.global_transform.basis.z
	var query = PhysicsRayQueryParameters3D.create(origin, origin + direction * 200)
	query.exclude = [get_parent().get_rid()]
	var hit := muzzle.get_world_3d().direct_space_state.intersect_ray(query)
	
	if hit.is_empty():
		print('miss')
	else:
		print("hit: ",hit.collider.name)
