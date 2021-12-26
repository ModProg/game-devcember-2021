tool
extends State

var target_in_hitbox = []

func _on_enter(_args) -> void:
	play("EnemyAttack")
	_apply_damage ()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "EnemyAttack":
		var _s = change_state("BlindSkeletonIdleState")

func _on_exit(args) -> void:
	target.movement = target.ant_movement

func _apply_damage () -> void:
	for hitted in target_in_hitbox:
		if !hitted.has_method("receive_damage"):
			continue
		hitted.call("receive_damage", target.attack_dmg)

func _on_AttackTrigger_body_entered(body):
	target_in_hitbox.append(body)

func _on_AttackTrigger_body_exited(body):
	target_in_hitbox.remove(target_in_hitbox.find(body))
