tool
extends State


func _on_enter(args) -> void:
	target.double_jumped = false

func _on_update(delta):
	if abs(target.movement) > 0:
		target.velocity.x = lerp(target.velocity.x, target.air_speed * target.movement, target.acceleration * delta)
	else:
		target.velocity.x = lerp(target.velocity.x,  0, target.air_friction * delta)
		if abs(target.velocity.x) < target.walk_margin: target.velocity.x = 0

	if Input.is_action_just_pressed("Attack"):
		var _s = change_state("AirMeleeAttack")

	if Input.is_action_just_pressed("dash") and not target.dashed:
		change_state("Dash")
