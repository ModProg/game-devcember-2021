tool
extends State

onready var raycast: RayCast2D

# FUNCTIONS TO INHERIT #
func _on_enter(_args):
	if target.velocity.y >= 0: play("Fall")
	else: play("FlyUp")

func _on_update(delta):
	if target.is_on_floor():
		var _s = change_state("SlimePatrol")
		return

	if target.velocity.y < 0 && target.velocity.y > -200 && !is_playing("TopCurve"):
		play("TopCurve")
	
	target.velocity.y += delta * target.gravity

# Called from the track method call in AnimationPlayer, anim "Fall"
func _on_top_curve_finished():
	play("Fall")

func _on_exit(_args):
	raycast.enabled = false
