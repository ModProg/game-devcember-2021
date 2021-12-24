tool
extends State

var _chase_direction = Vector2.ZERO
var attack_cooldown = false
var chase_movement = 1

func _on_enter(_args) -> void:
	chase_movement = target.movement

func _on_update(_delta) -> void:
	if target.chase_target == null:
		var _s = change_state("SlimePatrol")
		return
	_chase_direction = target.chase_target.position - target.position
	if _chase_direction.x <= 0 && target.movement >= 0:
		get_parent().flip()
	elif _chase_direction.x > 0 && target.movement < 0:
		get_parent().flip()
	if _chase_direction.length() <= target.attack_check_distance:
		if not attack_cooldown:
			attack_cooldown = true
			var _s = change_state("SlimeAttack")
		else:
			chase_movement = 0
	else:
		chase_movement = target.movement
	if get_parent().move_check ():
		var _s = change_state("SlimeJump")
	target.velocity.x = chase_movement * target.ground_speed

func _on_ChaseArea_body_exited(body):
	target.chase_target = null

func _on_AttackCooldown_timeout():
	attack_cooldown = false
