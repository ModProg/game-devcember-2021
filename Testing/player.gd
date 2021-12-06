class_name Player
extends PlatformerBody2D


export var stop_on_slopes := true


func _physics_process(delta: float) -> void:
	var hdirection := _get_hinput()
	
	apply_gravity(delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	elif Input.is_action_just_released("jump"):
		cut_jump()
	
	if should_decelerate(hdirection):
		apply_deceleration(delta)
	
	if should_accelerate(hdirection):
		apply_acceleration(delta, hdirection)
	
	velocity = move(delta, stop_on_slopes)


func _get_hinput() -> float:
	return sign(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
