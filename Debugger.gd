extends Node

# Simple script that pauses the game in debug mode when
# P is pressed

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_P):
		breakpoint
