extends Node

#Prototype of GameManager: Change to use the state machine after.

export var first_level := "first_level"

var current_scene = null
var loading_screen = null
var pause_menu_screen = null
var game_over_screen = null

enum GameState {MAINMENU, PAUSEMENU, PLAYING, EXITING, GAMEOVER, LOADING}
var state = GameState.PLAYING

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.has_feature("standalone"):
		print("Running an exported build.")
	else:
		print("Running from the editor.")
	state = GameState.PLAYING
	
	#These nodes might have to be deleted and manage the UI differently
	loading_screen = get_node("/root/GameController/Menu/LoadingScreen") as Control
	pause_menu_screen = get_node("/root/GameController/Menu/PauseMenu") as Control
	game_over_screen = get_node("/root/GameController/Menu/GameOverScreen") as Control
	
	print(loading_screen)
	if loading_screen != null:
		loading_screen.hide()
	if pause_menu_screen != null:
		pause_menu_screen.hide()
	if game_over_screen != null:
		game_over_screen.hide()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func start_game () -> void:
	state = GameState.PLAYING
	#Set default PlayerStatus
	call_deferred("_loadScene", first_level)

func load_level (scenepath) -> void:
	state = GameState.LOADING
	call_deferred("_load_scene", scenepath)

#Change for Background Loading???
func _load_scene (scenepath) -> void:
	get_tree().paused = true
	loading_screen.show()
	current_scene.free()
	var s = ResourceLoader.load(scenepath)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	
	#Yield it is only to check the loading screen
	yield(get_tree().create_timer(2.0), "timeout") #This is to be deleted
	
	loading_screen.hide()
	state = GameState.PLAYING
	get_tree().paused = false

func save_checkpoint () -> void:
	pass

func load_checkpoint () -> void:
	pass

func pause_menu () -> void:
	state = GameState.PAUSEMENU
	pause_menu_screen.show()
	get_tree().paused = true

func resume_paused () -> void:
	state = GameState.PLAYING
	pause_menu_screen.hide()
	get_tree().paused = false

func quit_game () -> void:
	state = GameState.EXITING
	get_tree().quit()

func game_over () -> void:
	state = GameState.GAMEOVER
	get_tree().paused = true
	game_over_screen.show()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if state == GameState.PLAYING:
			pause_menu ()
		elif state == GameState.PAUSEMENU:
			resume_paused ()
