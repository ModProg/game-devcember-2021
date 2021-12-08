tool
extends State


func _on_update(delta) -> void:
	
	target.position = target.position.move_toward(target.player.position, target.speed * delta)
	if !target.get_node("PlayerDetector").get_overlapping_bodies().empty() and !has_timer("Idle"):
		add_timer("Idle", .1)

func _on_enter(_delta) -> void:
	play_blend("RESET", 0.5)
		
func _on_timer_timeout(name) -> void:
	change_state(name)
