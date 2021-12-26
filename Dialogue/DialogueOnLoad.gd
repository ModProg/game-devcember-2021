class_name DialogueOnLoad
extends Node

enum Timeline {
	Intro
}

export var timeline: String

onready var gamecontroller = get_node("/root/GameController")

func _ready():
	# We  need to check this, because the deletion on level load is too slow.
	if not gamecontroller.disable_on_load.has(get_path()):
		gamecontroller.add_disable_on_load(get_path())
		gamecontroller.show_dialog(timeline)
