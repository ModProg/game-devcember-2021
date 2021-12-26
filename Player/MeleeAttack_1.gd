tool
extends State

func _on_enter(_args) -> void:
	play("MeleeAttack_1")

func _after_enter(args) -> void:
	get_parent()._apply_damage ()

func _on_update(_delta) -> void:
	if Input.is_action_just_pressed("Attack"):
		var _s = change_state("MeleeAttack_2")

func on_attack_animation_finished () -> void:
	var _s = change_state("OnGround/Idle")
