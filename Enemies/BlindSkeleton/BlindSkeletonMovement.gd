tool
extends State

var _attacking = false

func _on_enter(_args) -> void:
	var _s = change_state("BlindSkeletonIdleState")

func _on_update(delta) -> void:
	walk_check ()
	target.velocity.x = target.movement * target.ground_speed
	target.velocity.y += delta * target.gravity

func _after_update(_delta):
	target.velocity = target.move_and_slide(target.velocity, Vector2.UP)

func walk_check () -> void:
	if not _attacking:
		if target.is_on_floor():
			if not target.ground_check.is_colliding() || target.wall_check_top.is_colliding() || target.wall_check_bottom.is_colliding():
				target.flip ()
				target.movement *= -1
			target.velocity.x = target.movement * target.ground_speed
