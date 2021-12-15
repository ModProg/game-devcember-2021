extends Area2D

var save_tip
var spawn_point

var detect_save := false

func _ready():
	save_tip = get_node("tipUI")
	spawn_point = get_node("SpawnPoint")
	save_tip.hide()

func _on_CheckPoint_body_entered(_body):
	detect_save = true
	save_tip.show()

func _on_CheckPoint_body_exited(_body):
	detect_save = false
	save_tip.hide()

func activate() -> void:
	var data = {
		"spawn_point_x" : spawn_point.global_position.x,
		"spawn_point_y" : spawn_point.global_position.y,
	}
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.save_checkpoint(data)

func _process(_delta):
	if Input.is_action_just_pressed("Interact"):
		activate()
