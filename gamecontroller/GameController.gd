extends Node

export var first_level := "first_level"

var current_scene = null
var loading_screen = null

# Called when the node enters the scene tree for the first time.
func _ready():
	loading_screen = get_node("/root/GameController/LoadingScreen") as Control
	if loading_screen != null:
		loading_screen.hide()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func start_game () -> void:
	#Set default PlayerStatus
	call_deferred("_loadScene", first_level)

func load_level (scenepath) -> void:
	call_deferred("_load_scene", scenepath)

func _load_scene (scenepath) -> void:
	_fade_out ()
	current_scene.free()
	var s = ResourceLoader.load(scenepath)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	_fade_in ()

func save_checkpoint () -> void:
	pass

func load_checkpoint () -> void:
	pass

func pause_menu () -> void:
	pass

func quit_game () -> void:
	get_tree().quit()

func game_over () -> void:
	pass

func _fade_out () -> void:
	pass

func _fade_in () -> void:
	pass
