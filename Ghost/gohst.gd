extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export var speed: float = 200
export var player_path: NodePath
onready var player: Player = get_node(player_path)
