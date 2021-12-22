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

func flip () -> void:
	target.flip ()
	target.movement *= -1

func jump () -> void:
	var _s = change_state("SlimeJump")

func jump_attack () -> void:
	var _s = change_state("SlimeAttack")

func _on_PlayerSpotArea_body_entered(body):
	if not is_active("SlimeChase") || not is_active("SlimeJump") || not is_active("SlimeAttack"):
		target.chase_target = body
		var _s = change_state("SlimeChase")

func _on_ChaseArea_body_exited(body):
	if is_active("SlimeChase"):
		target.chase_target = null
		var _s = change_state("SlimePatrol")
