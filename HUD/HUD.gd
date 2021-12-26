extends AspectRatioContainer

var player_status: PlayerStatus
onready var healthbar := $Container/StatusContainer/HealthBar
onready var potion_count_label := $Container/StatusContainer/MarginContainer/InventoryContainer/PotionCountContainer/PotionCountLabel

func _ready() -> void:
	call_deferred("_init_subscription")

func _init_subscription():
	player_status = GameController.player_status_node
	player_status.connect("change", self, "_on_player_status_change")
	_on_player_status_change()

func _on_player_status_change():
	healthbar.max_value = player_status.max_health
	healthbar.value = player_status.health
	potion_count_label.text = str(player_status.health_potion_amount) + "/" + str(player_status.health_potion_max)
