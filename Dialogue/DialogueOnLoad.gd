class_name DialogueOnLoad
extends Node

enum Timeline {
	Intro
}

export var timeline: String

onready var gamecontroller = get_node("/root/GameController")

func _ready():
	gamecontroller.show_dialog(timeline)
