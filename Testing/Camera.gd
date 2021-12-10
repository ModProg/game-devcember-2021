extends Camera2D
class_name MainCamera

export (NodePath) var target
export (bool) var debug = false
export (Vector2) var velocity_sensitivity = Vector2(30, 10)
export (float) var acceleration = 1

var target_vel = Vector2(0, 0)

onready var target_node: Node2D = get_node(target) as Node2D
onready var last_target_pos = target_node.global_position


func _physics_process(delta: float) -> void:
	var current_target_pos = target_node.global_position
	target_vel = current_target_pos - last_target_pos
	# When player is barely moving don't return camera to center
	# Feels more natural that way for some reason
	if target_vel.length_squared() > 0.2:
		var desired_camera_pos = current_target_pos + (target_vel * velocity_sensitivity)
		global_position = lerp(global_position, desired_camera_pos, acceleration * delta)
	last_target_pos = current_target_pos
	if debug:
		update()

func _draw() -> void:
	if debug:
		draw_line(Vector2.ZERO, target_vel * 10, Color.blueviolet, 4)
