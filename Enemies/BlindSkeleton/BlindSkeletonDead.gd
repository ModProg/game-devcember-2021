tool
extends State


# FUNCTIONS AVAILABLE TO INHERIT

func _on_enter(_args) -> void:
	play("EnemyDeath")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "EnemyDeath":
		print("Death")
		target.queue_free()
