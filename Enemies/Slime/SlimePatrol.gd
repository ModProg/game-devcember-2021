tool
extends State

#func _on_enter(_args) -> void:
#	pass

func _on_update(delta) -> void:
	if get_parent().move_check ():
		get_parent().flip()
	target.velocity.x = target.movement * target.ground_speed

func _on_PlayerSpotArea_body_entered(body):
	if is_active("SlimePatrol"):
		target.chase_target = body
		var _s = change_state("SlimeChase")
