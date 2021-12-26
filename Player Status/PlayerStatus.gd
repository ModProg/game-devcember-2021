extends Node

export (int) var max_health
export (int) var health
export (int) var max_mana
export (int) var mana

export (int) var mana_regen_rate = 1.0

export (int) var health_potion_amount
export (int) var health_potion_max

#Skills unlocked
export (bool) var has_double_jump = false
export (bool) var has_dash = false

func add_health (heal) -> void:
	health += heal
	if health > max_health:
		health = max_health

func reduce_health (damage) -> void:
	health -= damage
	if health <= 0:
		_player_death ()

func _player_death () -> void:
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.player_node.player_death()
	gamecontroller.game_over()

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"health" : health,
		"max_health" : max_health,
		"mana" : mana,
		"max_mana" : max_mana,
		"mana_regen_rate" : mana_regen_rate,
		"health_potion_amount" : health_potion_amount,
		"health_potion_max" : health_potion_max,
		"has_double_jump" : has_double_jump,
		"has_dash" : has_dash,
	}
	return save_dict
