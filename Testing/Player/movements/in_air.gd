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
