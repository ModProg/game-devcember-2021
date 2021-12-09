tool
extends State

var loader
var wait_frames
var time_max = 100

func _on_enter(_args) -> void:
	loader = ResourceLoader.load_interactive(_args)
	if loader == null: # Check for errors.
		print_debug("Error loading Level asset")
		_show_error()
		return
	#set_process(true)
	target.current_scene.queue_free()
	target.loading_screen.show()
	wait_frames = 1

func _on_update(_delta) -> void:
	if loader == null:
		# no need to process anymore
		change_state("PlayingState")
		return

	if wait_frames > 0:
		wait_frames -= 1
		return
	
	var t = OS.get_ticks_msec()
	
	while OS.get_ticks_msec() < t + time_max:
		# Poll your loader.
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			target.current_scene = resource.instance()
			loader = null
			get_tree().get_root().add_child(target.current_scene)
			get_tree().set_current_scene(target.current_scene)
			change_state("PlayingState")
			break
		elif err == OK:
			_update_progress()
		else: # Error during loading.
			_show_error()
			loader = null
			break

func _update_progress () -> void:
	print_debug("Loading Level")

func _show_error () -> void:
	print_debug("Loader failed to Load Level")
	get_tree().quit(-1)

func _on_exit(_args) -> void:
	target.loading_screen.hide()
