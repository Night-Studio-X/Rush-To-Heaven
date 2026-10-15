extends Node3D

@export var camera: Camera3D
@export var gun_pivot: Node3D
@export var turret_pivot: Node3D
@export var turret_speed: float = 90.0

func _process(delta: float) -> void:
	var cursor_pos = get_viewport().get_mouse_position()
	
	var ray_origin = camera.project_ray_origin(cursor_pos)
	var ray_direction = camera.project_ray_normal(cursor_pos)
	
	var query = PhysicsRayQueryParameters3D.create(
		ray_origin,
		ray_origin + ray_direction * 1000
	)
	
	query.exclude = [get_parent().get_rid()]
	
	var hit = get_world_3d().direct_space_state.intersect_ray(query)
	
	var target_position = ray_origin + ray_direction * 1000
	if not hit.is_empty():
		target_position = hit.position
		
		
	var direction_for_turret_pivot = target_position - turret_pivot.global_position
	direction_for_turret_pivot.y = 0
	
	if direction_for_turret_pivot.length() > 0.01:
		var target_yaw = atan2(-direction_for_turret_pivot.x, -direction_for_turret_pivot.z)
		turret_pivot.global_rotation.y += clamp(angle_difference(turret_pivot.global_rotation.y, target_yaw), -deg_to_rad(turret_speed) * delta, deg_to_rad(turret_speed) * delta)
	
	
	var local_target = turret_pivot.to_local(target_position)
	var direction_for_gun_pivot = local_target - gun_pivot.position
	var flat_distance = Vector2(direction_for_gun_pivot.x, direction_for_gun_pivot.z).length()
	gun_pivot.rotation.x = atan2(direction_for_gun_pivot.y, flat_distance)
	
	
	
