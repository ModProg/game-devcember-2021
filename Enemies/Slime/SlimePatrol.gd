tool
extends State

func _on_enter(_args) -> void:
#	print ("Patrol")
	pass

func _on_update(delta) -> void:
	if get_parent().move_check ():
		get_parent().flip()
	target.velocity.x = target.movement * target.ground_speed