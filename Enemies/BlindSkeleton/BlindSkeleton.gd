extends KinematicBody2D
class_name BlindSkeleton

onready var _attack_node := $Attack
onready var attack_scan := $Attack/AttackTrigger
onready var attack_player_check := $Attack/PlayerCheck
onready var _checks_node := $WalkChecks
onready var ground_check := $WalkChecks/GroundCheck
onready var wall_check_top := $WalkChecks/WallCheckTop
onready var wall_check_bottom := $WalkChecks/WallCheckBottom
onready var state_root := $StateRoot

var velocity = Vector2()
export (int) var movement = 1
var ant_movement

export (int) var gravity = 2000
export (int) var acceleration = 15

export (int) var ground_speed = 200
export (int) var walk_margin = 80

export (float) var stun_time = 0.5

export (int) var enemy_hp = 1
export (int) var attack_dmg = 1

func _ready():
	state_root.change_state("BlindSkeletonIdleState")

func flip () -> void:
	_attack_node.scale.x *= -1
	_checks_node.scale.x *= -1

func attack_check () -> bool:
	if attack_player_check.is_colliding():
		ant_movement = movement
		movement = 0
		return true
	return false

func receive_damage (damage) -> void:
	enemy_hp -= damage
	if enemy_hp <= 0:
		enemy_death()
	else:
		state_root.change_state("BlindSkeletonStunned")

func enemy_death () -> void:
	state_root.change_state("BlindSkeletonDead")
