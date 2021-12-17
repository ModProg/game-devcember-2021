class_name DialogueTrigger
extends Area2D

export var timeline: String
export var once := true

onready var gamecontroller = get_node("/root/GameController")

func player_entered(_body):
	gamecontroller.show_dialog(timeline)
	if once:
		queue_free()
