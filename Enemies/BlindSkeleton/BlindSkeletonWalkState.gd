tool
extends State

# FUNCTIONS TO INHERIT #
func _on_enter(_args):
	play("EnemyWalk")

func _on_update(_delta):
	if target.attack_check ():
		change_state("BlindSkeletonAttackState")
	if abs(target.velocity.x) < target.walk_margin:
		var _s = change_state("BlindSkeletonIdleState")
