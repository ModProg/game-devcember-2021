tool
extends State

func _on_enter(_args) -> void:
	if target.stun_time > 0:
		add_timer("Stunned_time", target.stun_time)
		play("Stunned")
	else:
		var _s = change_state("BlindSkeletonIdleState")

func _on_exit(_args) -> void:
	del_timers()

func _on_timeout(_name) -> void:
	var _s = change_state("BlindSkeletonIdleState")
