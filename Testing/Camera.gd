extends Camera2D
class_name MainCamera

export (NodePath) var target
export (bool) var debug = false
export (Vector2) var velocity_sensitivity = Vector2(30, 10)
export (float) var acceleration = 1

var target_vel := Vector2(0, 0)
var is_snapped_to_attractor := false
var attracted_pos := Vector2.ZERO

onready var target_node := get_node(target) as PhysicsBody2D
onready var attractor_trigger_node := $CameraTrigger
onready var last_target_pos = target_node.global_position

var attractors = []

func _get_attractor_blend_factor(current_pos: Vector2, attractor: CameraAttractor) -> Vector2:
	var pos = attractor.global_position
	var distance = (pos - current_pos).length()
	var factor = max(distance - attractor.inner_radius, 0) / (attractor.outer_radius - attractor.inner_radius)
	return 1 - factor


func _aggregate_attractors_desired_pos() -> void:
	var current_pos = target_node.global_position
	attracted_pos = Vector2.ZERO
	for val in attractors:
		var attractor := val as CameraAttractor
		var pos = attractor.global_position
		var factor = _get_attractor_blend_factor(current_pos, attractor)
		if is_equal_approx(factor, 1):
			is_snapped_to_attractor = true
			attracted_pos = pos
			return
		attracted_pos += lerp(current_pos, pos, factor)
	if len(attractors) > 0:
		attracted_pos = attracted_pos / len(attractors)
	else:
		attracted_pos = current_pos
	
	is_snapped_to_attractor = false


func _physics_process(delta: float) -> void:
	var current_target_pos := target_node.global_position
	attractor_trigger_node.global_position = current_target_pos
	
	target_vel = current_target_pos - last_target_pos
	_aggregate_attractors_desired_pos()
	var desired_camera_pos = attracted_pos
	# When player is barely moving don't return camera to center
	# Feels more natural that way for some reason
	if target_vel.length_squared() > 0.2 and not is_snapped_to_attractor:
		desired_camera_pos = desired_camera_pos + (target_vel * velocity_sensitivity)
	global_position = lerp(global_position, desired_camera_pos, acceleration * delta)
	last_target_pos = current_target_pos
	if debug:
		update()


func _draw() -> void:
	if debug:
		draw_line(Vector2.ZERO, target_vel * 10, Color.blueviolet, 4)
		var current_target_pos := target_node.global_position
		for atr in attractors:
			var pos = atr.global_position
			var factor = _get_attractor_blend_factor(current_target_pos, atr)
			draw_circle(
				transform.affine_inverse().xform(lerp(current_target_pos, pos, factor)),
				4, Color.beige
			)


func _on_CameraTrigger_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is CameraAttractor:
		attractors.append(parent as CameraAttractor)


func _on_CameraTrigger_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is CameraAttractor:
		attractors.erase(parent)
