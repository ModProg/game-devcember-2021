tool
extends State

func _on_enter(_args) -> void:
	play("EnemyAttack")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "EnemyAttack":
		var _s = change_state("BlindSkeletonIdleState")

func _on_exit(args) -> void:
	target.movement = target.ant_movement
