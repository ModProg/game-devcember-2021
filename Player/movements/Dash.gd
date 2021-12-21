tool
extends State

var dash_dir

func _on_enter(_args) -> void:
	target.dashed = true
	dash_dir = target.dir
	add_timer("dash_end", target.dash_duration)
	target.dashing = true
	(target as KinematicBody2D).collision_mask

func _on_update(_delta) -> void:
	target.velocity = Vector2(target.dash_velocity * dash_dir, 0)

func _on_timeout(_name) -> void:
	if _name == "dash_end":
		change_state("Fall")

func _on_exit(_args) -> void:
	target.dashing = false
