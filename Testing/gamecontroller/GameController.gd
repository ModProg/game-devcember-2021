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
	current_scene.queue_free()
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
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(to_json(node_data))
	save_game.close()

func load_checkpoint () -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
	save_game.close()


func pause_menu () -> void:
	state = GameState.PAUSEMENU
	pause_menu_screen.show()
	get_tree().paused = true

func resume_paused () -> void:
	state = GameState.PLAYING
	pause_menu_screen.hide()
	get_tree().paused = false

func quit_game () -> void:
	get_tree().paused = true
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
