extends Node

export var first_level := "first_level"
export var main_menu_scene := ""

#current scene being played. E.g.: First level
var current_scene: Node = null

#Player status scene file name
export var player_status := ""
#Player status node
var player_status_node: PlayerStatus = null
#reference to player node
var player_node = null

#Array of absolut NodePaths
var disable_on_load := []

onready var loading_screen := $Menu/LoadingScreen
onready var pause_menu_screen := $Menu/PauseMenu
onready var game_over_screen := $Menu/GameOverScreen
onready var darken_screen := $DarkenScreen/ColorRect
onready var hud_screen := $Menu/HUDScreen

enum GameState {MAINMENU, PAUSEMENU, PLAYING, EXITING, GAMEOVER, LOADING}
var state = GameState.PLAYING

var dialogue = null
# Called when the node enters the scene tree for the first time.
func _ready():
	create_player_status ()
	if loading_screen != null:
		loading_screen.hide()
	if pause_menu_screen != null:
		pause_menu_screen.hide()
	if game_over_screen != null:
		game_over_screen.hide()
	if darken_screen != null:
		darken_screen.hide()
	if hud_screen != null:
		hud_screen.hide()

	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func create_player_status () -> void:
	if player_status_node == null:
		var status = ResourceLoader.load(player_status)
		player_status_node = status.instance()
		add_child(player_status_node)

func start_game () -> void:
	call_deferred("_load_scene", first_level)
	state = GameState.PLAYING

func load_main_menu () -> void:
	load_level(main_menu_scene)
	end_dialog("")
	resume_paused ()
	state = GameState.MAINMENU

func load_level (scenepath) -> void:
	call_deferred("_load_scene", scenepath)

func _load_scene (scenepath) -> void:
	loading_screen.show()
	current_scene.queue_free()
	var s = ResourceLoader.load(scenepath)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	#get_tree().set_current_scene(current_scene)
	loading_screen.hide()
	player_node = current_scene.get_node("Player")
	if state == GameState.MAINMENU:
		hud_screen.hide()
	else:
		hud_screen.show()

func save_checkpoint (spawn_point_data) -> void:
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)

	#save level to reload
	var level_data = {"level" : current_scene.get_filename()}
	print(level_data)
	save_game.store_line(to_json(level_data))

	#save player status
	var player_status_data = player_status_node.save()
	save_game.store_line(to_json(player_status_data))

	#save checkpoint spawn position
	save_game.store_line(to_json(spawn_point_data))

	save_game.store_line(to_json(disable_on_load))

	save_game.close()

func load_checkpoint () -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegame.save", File.READ)
	# Get level file name
	var level_data = parse_json(save_game.get_line())
	_load_scene ( level_data["level"] )
	# Load Player data
	var player_status_data = parse_json(save_game.get_line())

	for i in player_status_data.keys():
		player_status_node.set(i, player_status_data[i])
	#Position the player in the checkpoint
	var spawn_data = parse_json(save_game.get_line())
	player_node.position = Vector2(spawn_data["spawn_point_x"], spawn_data["spawn_point_y"])

	disable_on_load = parse_json(save_game.get_line())
	for disable_path in disable_on_load:
		print(get_node(disable_path))
		get_node(disable_path).free()
		print(get_node(disable_path))
	save_game.close()
	resume_paused ()
	hud_screen.show()

func pause_menu () -> void:
	pause_menu_screen.show()
	get_tree().paused = true
	state = GameState.PAUSEMENU

func resume_paused () -> void:
	pause_menu_screen.hide()
	if !dialogue:
		get_tree().paused = false
	state = GameState.PLAYING

func show_dialog(name: String) -> void:
	darken_screen.show()
	get_tree().paused = true
	# Maybe use substates because you can pausemenue during dialogue idk
	# state = DIALOGUE
	dialogue = Dialogic.start(name)
	dialogue.connect("timeline_end", self, "end_dialog")
	add_child(dialogue)
	hud_screen.hide()

func end_dialog(_timeline) -> void:
	darken_screen.hide()
	get_tree().paused = false
	# Maybe use substates because you can pausemenue during dialogue idk
	# state = DIALOGUE
	if dialogue:
		dialogue.queue_free()
		dialogue = null
	hud_screen.show()

func add_disable_on_load(node_path):
	disable_on_load.push_back(node_path)

func quit_game () -> void:
	current_scene.queue_free()
	player_status_node.queue_free()
	queue_free()
	get_tree().quit()

func game_over () -> void:
	game_over_screen.show()

func _process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		if state == GameState.PLAYING:
			pause_menu ()
		elif state == GameState.PAUSEMENU:
			resume_paused ()
