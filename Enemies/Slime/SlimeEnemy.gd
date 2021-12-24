extends KinematicBody2D
class_name SlimeEnemy

onready var _attack_node := $AttackChecks
onready var attack_area := $AttackChecks/AttackArea
onready var _checks_node := $WalkChecks
onready var ground_check := $WalkChecks/GroundCheck
onready var wall_check_top := $WalkChecks/WallCheckTop
onready var wall_check_bottom := $WalkChecks/WallCheckBottom
onready var state_root := $StateRoot

export (float) var attack_cooldown_time = 4.0
onready var attack_cooldown_timer := $AttackCooldown

var velocity = Vector2()
export (int) var movement = 1
var ant_movement

var chase_target = null

export (int) var gravity = 2000
export (int) var acceleration = 15

export (int) var ground_speed = 200
export (int) var walk_margin = 80

export (int) var jump_speed = 750
export (int) var air_speed = 500
export (int) var air_friction = 8

#Combat related
export (int) var jump_attack_speed = 500
export (int) var air_attack_speed = 800
export (int) var attack_check_distance = 150
export (int) var melee_damage = 1

export (float) var prejump_time = 0.3
export (float) var jump_time = 0.2

export (float) var stun_time = 0.5

export (int) var enemy_hp = 1
export (int) var attack_dmg = 1

func _ready():
	state_root.change_state("")

func flip () -> void:
	_attack_node.scale.x *= -1
	_checks_node.scale.x *= -1

func receive_damage (damage) -> void:
	enemy_hp -= damage
	if enemy_hp <= 0:
		enemy_death()
	else:
		state_root.change_state("")

func enemy_death () -> void:
	state_root.change_state("")
