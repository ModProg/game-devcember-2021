extends Node

var max_health
var health
var max_mana
var mana

var health_potion_amount
var health_potion_max

func add_health (heal) -> void:
	health += heal
	if health > max_health:
		health = max_health

func reduce_health (damage) -> void:
	health -= damage
	if health <= 0:
		#player dies
		pass
