tool
extends State


onready var raycast: RayCast2D

# FUNCTIONS TO INHERIT #
func _on_enter(_args):
	if not raycast:
		raycast = target.get_node("RayCast2D")
	if target.velocity.y >= 0: play("Fall")
	else: play("FlyUp")
	if state_root.was_state_active("OnGround"):
		add_timer("CoyoteTime", target.coyote_time)
	if state_root.was_state_active("Jump"):
		pass


func _on_update(_delta):
	if target.is_on_floor() && get_node_or_null("PreJump") != null:
		var _s = change_state("Jump")
		return
	if target.is_on_floor():
		var _s = change_state("Land")
		return

	if target.velocity.y < 0 && target.velocity.y > -200 && !is_playing("TopCurve"):
		play("TopCurve")

	var is_jump_pressed = Input.is_action_just_pressed("jump")
	if is_jump_pressed && get_node_or_null("CoyoteTime") != null:
		var _s = change_state("Jump")
	elif is_jump_pressed && not target.double_jumped and not raycast.is_colliding():
		var _s = change_state("DoubleJump")
	elif is_jump_pressed:
		var _t = add_timer("PreJump",target.prejump_time)


# Called from the track method call in AnimationPlayer, anim "Fall"
func _on_top_curve_finished():
	play("Fall")


func _on_exit(_args):
	raycast.enabled = false
