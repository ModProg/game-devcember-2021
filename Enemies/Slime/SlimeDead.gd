tool
extends State

func _on_enter(_args) -> void:
	play("SlimeDeath")

func _after_update(delta):
	target.velocity.y += delta * target.gravity
	target.velocity = target.move_and_slide(target.velocity, Vector2.UP)

func _dead_animation_finished() -> void:
	target.queue_free()
