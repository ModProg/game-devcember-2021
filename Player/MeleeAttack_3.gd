tool
extends State

func _on_enter(_args) -> void:
	print("MeleeAttack_3")
	play("MeleeAttack_3")

func _after_enter(args) -> void:
	get_parent()._apply_damage ()

func on_attack_animation_finished () -> void:
	var _s = change_state("OnGround/Idle")
