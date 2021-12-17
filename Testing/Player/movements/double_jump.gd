tool
extends State


# Simple state to transition out of "Jump" and back in again
func _on_enter(_args) -> void:
	target.double_jumped = true


func _after_enter(_args) -> void:
	var _s = change_state("Jump")
