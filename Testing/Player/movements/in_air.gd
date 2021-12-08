tool
extends State

var double_jumped = false

func _on_enter(_arg):
	double_jumped = false

# FUNCTIONS TO INHERIT #
func _on_update(delta):
	if target.dir != 0:
		target.velocity.x = lerp(target.velocity.x, target.air_speed * target.dir, target.acceleration * delta)
	if target.dir == 0:
		target.velocity.x = lerp(target.velocity.x,  0, target.air_friction * delta)
		if abs(target.velocity.x) < target.walk_margin: target.velocity.x = 0

	if Input.is_action_just_pressed("jump") and not double_jumped:
		double_jumped = true
		change_state("DoubleJump")
