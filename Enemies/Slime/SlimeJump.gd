tool
extends State

func _on_enter(_args):
	play("Jump")
	target.velocity.y = -target.jump_speed

func _on_update(_delta):
	if target.is_on_floor ():
		var _s = change_state("SlimeChase")
	if target.velocity.y > 0:
		play("Fall")
	target.velocity.x = target.movement * target.air_speed
