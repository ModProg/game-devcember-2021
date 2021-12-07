class_name Player
extends PlatformerBody2D


export var stop_on_slopes := true
export var coyote_time: float = 1

var jumped := false
var time_since_ground: float

func _physics_process(delta: float) -> void:
	var hdirection := _get_hinput()
	print(time_since_ground < coyote_time)
	
	apply_gravity(delta)
	if Input.is_action_just_pressed("jump") and (close_to_floor() or was_on_floor()) :
		jumped = true
	if jumped:
		if is_on_floor() or was_on_floor():
			jump()
			jumped = false
		if !close_to_floor():
			jumped = false
	elif Input.is_action_just_released("jump"):
		cut_jump()
	
	if should_decelerate(hdirection):
		apply_deceleration(delta)
	
	if should_accelerate(hdirection):
		apply_acceleration(delta, hdirection)
	
	velocity = move(delta, stop_on_slopes)
	
	if is_on_floor():
		time_since_ground = 0
	else:
		time_since_ground += delta
	
func was_on_floor() -> bool:
	return time_since_ground < coyote_time
	
func close_to_floor() -> bool:
	return !$GroundDetector.get_overlapping_bodies().empty()

func _get_hinput() -> float:
	return sign(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
