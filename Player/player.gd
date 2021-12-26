extends KinematicBody2D
class_name Player
# All the logic is handled by the xsm below
# The Player script is only declaring variables
# Those variables can be acccessed in your States with target.variable

var velocity = Vector2()
var movement = 0
var dir = 1
var double_jumped = false
var dashed = false
var dashing = false

#Combat related
var target_in_hitbox = []
export (int) var melee_damage = 1

export (int) var gravity = 2000
export (int) var acceleration = 15

export (int) var ground_speed = 250
export (int) var ground_friction = 10
export (int) var walk_margin = 80
export (int) var run_margin = 150

export (int) var jump_speed = 25000
export (int) var air_speed = 350
export (int) var air_friction = 8

# Time in seconds when player can jump after he fell off the platform
export (float) var coyote_time = 0.2
export (float) var prejump_time = 0.3
export (float) var jump_time = 0.2

func _on_AttackArea_body_entered(body):
	target_in_hitbox.append(body)

func _on_AttackArea_body_exited(body):
	target_in_hitbox.remove(target_in_hitbox.find(body))

func receive_damage (damage) -> void:
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.player_status_node.reduce_health(damage)

func player_death () -> void:
	var state = get_node("StateRoot")
	state.change_state("")
export (float) var dash_duration = 0.2
export (float) var dash_velocity = 2000
