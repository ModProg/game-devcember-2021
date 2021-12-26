tool
extends State

var target_in_hitbox = []

func _on_enter(_args):
	play("Jump")
	_apply_damage ()
	target.velocity.y = -target.jump_attack_speed

func _on_update(_delta):
	if target.is_on_floor ():
		var _s = change_state("SlimeChase")
	if target.velocity.y > 0:
		play("Fall")
	target.velocity.x = target.movement * target.air_attack_speed

func _apply_damage () -> void:
	for hitted in target_in_hitbox:
		if !hitted.has_method("receive_damage"):
			continue
		hitted.call("receive_damage", target.melee_damage)
		target_in_hitbox.remove(target_in_hitbox.find(hitted))

func _on_exit(_args) -> void:
	target.attack_cooldown_timer.start(target.attack_cooldown_time)

func _on_AttackArea_body_entered(body):
	target_in_hitbox.append(body)
	if is_active("SlimeAttack"):
		_apply_damage ()

func _on_AttackArea_body_exited(body):
	if target_in_hitbox.size() > 0:
		target_in_hitbox.remove(target_in_hitbox.find(body))
