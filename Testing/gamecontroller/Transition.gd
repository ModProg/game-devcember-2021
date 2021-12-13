extends Area2D

export (String) var to_level

func _on_Transition_body_entered(body):
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.load_level(to_level)
