tool
extends State


# FUNCTIONS AVAILABLE TO INHERIT


func _on_enter(_delta) -> void:
	play_blend("Idle", 1)

func _on_update(_delta) -> void:
	if target.get_node("PlayerDetector").get_overlapping_bodies().empty() and !has_timer("MoveToPlayer"):
		add_timer("MoveToPlayer", .1)
		
func _on_timer_timeout(name) -> void:
	change_state(name)
