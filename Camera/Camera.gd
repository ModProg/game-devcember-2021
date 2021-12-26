extends Camera2D
class_name MainCamera

export (NodePath) var target
export (bool) var debug = false
export (Vector2) var velocity_sensitivity = Vector2(30, 10)
export (float) var acceleration = 1
export (float) var dash_acceleration = 2

var target_vel := Vector2(0, 0)
var is_snapped_to_attractor := false
var attracted_pos := Vector2.ZERO
var attracted_zoom := 1.0
var closest_attractor_factor := 0.0

onready var target_node := get_node(target) as PhysicsBody2D
onready var attractor_trigger_node := $CameraTrigger
onready var last_target_pos = target_node.global_position
onready var initial_zoom = zoom.x # assume zoom is same on x and y

var attractors = []

func _ease_pos(factor: float) -> float:
	 return ease(factor, 2)
	
func _ease_zoom(factor: float) -> float:
	return ease(factor, -1.3)

func _get_attractor_blend_factor(current_pos: Vector2, attractor: CameraAttractor) -> float:
	var pos = attractor.global_position
	var distance = (pos - current_pos).length()
	var factor = max(distance - attractor.inner_radius, 0) / (attractor.outer_radius - attractor.inner_radius)
	return 1 - factor

func _aggregate_attractors_desired_pos() -> void:
	var current_pos = target_node.global_position
	attracted_pos = Vector2.ZERO
	attracted_zoom = 0
	closest_attractor_factor = 0.0
	for val in attractors:
		var attractor := val as CameraAttractor
		var pos = attractor.global_position
		var factor = _get_attractor_blend_factor(current_pos, attractor)
		if factor > closest_attractor_factor:
			closest_attractor_factor = factor
		if is_equal_approx(factor, 1):
			is_snapped_to_attractor = true
			attracted_pos = pos
			attracted_zoom = attractor.zoom
			return
		attracted_pos += lerp(current_pos, pos, _ease_pos(factor))
		attracted_zoom += lerp(initial_zoom, attractor.zoom, _ease_zoom(factor))
	if len(attractors) > 0:
		attracted_pos /= len(attractors)
		attracted_zoom /= len(attractors)
	else:
		attracted_pos = current_pos
		attracted_zoom = initial_zoom

	is_snapped_to_attractor = false

func _physics_process(delta: float) -> void:
	var current_target_pos := target_node.global_position
	attractor_trigger_node.global_position = current_target_pos

	target_vel = current_target_pos - last_target_pos
	_aggregate_attractors_desired_pos()
	var desired_camera_pos = attracted_pos
	# When player is barely moving don't return camera to center
	# Feels more natural that way for some reason
	if target_vel.length_squared() > 0.2:
		var inv_attractor_factor = 1 - closest_attractor_factor
		desired_camera_pos = desired_camera_pos + (target_vel * velocity_sensitivity * inv_attractor_factor)
	var accel
	if target_node.dashing:
		accel = dash_acceleration
	else:
		accel = acceleration
	global_position = lerp(global_position, desired_camera_pos, accel * delta)
	last_target_pos = current_target_pos
	zoom = Vector2(attracted_zoom, attracted_zoom)
	if debug:
		update()

func _draw() -> void:
	if debug:
		draw_line(Vector2.ZERO, target_vel * 10, Color.blueviolet, 4)
		var current_target_pos := target_node.global_position
		for atr in attractors:
			var pos = atr.global_position
			var factor = _get_attractor_blend_factor(current_target_pos, atr)
			factor = _ease_pos(factor)
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
