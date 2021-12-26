tool
extends State


func _apply_damage () -> void:
	for hitted in target.target_in_hitbox:
		if !hitted.has_method("receive_damage"):
			print ("Target does not have damage method")
			continue
		hitted.call("receive_damage", target.melee_damage)
