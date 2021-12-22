extends Node

export (float) var damage = 5
export (float) var interval = 5

var player_status: PlayerStatus

var time = 0.0

func _ready() -> void:
	call_deferred("_init_status")
	
func _init_status():
	player_status = GameController.player_status_node

func _physics_process(delta: float) -> void:
	time += delta
	
	if time > interval:
		player_status.reduce_health(damage)
		print("dealing " + str(damage) + "damage")
		time -= interval
