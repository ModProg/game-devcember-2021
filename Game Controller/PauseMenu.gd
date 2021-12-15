extends Control

func _on_ResumeButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.resume_paused()


func _on_QuitButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.quit_game()


func _on_MainMenuButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.load_main_menu()


func _on_RestartButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.load_checkpoint()
