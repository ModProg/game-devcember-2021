tool
extends State

func _after_update(delta):
	target.velocity.y += delta * target.gravity
	target.velocity = target.move_and_slide(target.velocity, Vector2.UP)

func move_check () -> bool:
	if target.is_on_floor():
		if not target.ground_check.is_colliding() || target.wall_check_top.is_colliding() || target.wall_check_bottom.is_colliding():
			return true
	return false

func move_wall_check () -> bool:
	if target.is_on_floor():
		if target.wall_check_top.is_colliding() || target.wall_check_bottom.is_colliding():
			return true
	return false

func move_floor_check () -> bool:
	if target.is_on_floor():
		if not target.ground_check.is_colliding():
			return true
	return false

func flip () -> void:
	target.flip ()
	target.movement *= -1
