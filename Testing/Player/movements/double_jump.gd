tool
extends State

# Simple state to transition out of "Jump" and back in again

func _after_enter(_args) -> void:
	change_state("Jump")
