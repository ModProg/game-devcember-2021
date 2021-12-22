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
	
	if Input.is_action_just_pressed("dash"):
		if is_active("OnGround") and not target.ground_dashed:
			target.ground_dashed = true
			add_timer("ground_dash_timeout", target.dash_ground_interval)
			change_state("Dash")
		
		if is_active("InAir") and not target.dashed:
			change_state("Dash")

func _after_update(_delta):
	target.velocity = target.move_and_slide(target.velocity, Vector2.UP)

func _on_timeout(name):
	if name == "ground_dash_timeout":
		target.ground_dashed = false
