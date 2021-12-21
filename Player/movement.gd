tool
extends State


# FUNCTIONS TO INHERIT #
func _on_update(delta):
	var x_input = Input.get_axis("move_left", "move_right")
	target.movement = x_input
	
	if abs(x_input) > 0:
		target.dir = sign(x_input)
		target.get_node("Sprite").flip_h = target.dir < 0

	target.velocity.y += delta * target.gravity
	

func _after_update(_delta):
	target.velocity = target.move_and_slide(target.velocity, Vector2.UP)
