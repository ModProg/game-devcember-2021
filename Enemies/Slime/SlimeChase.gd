tool
extends State

var _chase_direction = Vector2.ZERO

func _on_enter(_args) -> void:
#	print ("Chase")
	pass

func _on_update(_delta) -> void:
	_chase_direction = target.chase_target.position - target.position
	if _chase_direction.x <= 0 && target.movement >= 0:
		get_parent().flip()
	elif _chase_direction.x > 0 && target.movement < 0:
		get_parent().flip()
	if get_parent().move_check ():
		get_parent().jump()
	target.velocity.x = target.movement * target.ground_speed

func _on_AttackSpotArea_body_entered(body):
#	get_parent().jump_attack()
	pass
