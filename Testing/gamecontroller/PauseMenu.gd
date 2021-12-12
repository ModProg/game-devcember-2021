extends Control

func _on_ResumeButton_pressed():
	GameController.resume_paused()


func _on_QuitButton_pressed():
	GameController.quit_game()


func _on_MainMenuButton_pressed():
	GameController.load_main_menu()


func _on_RestartButton_pressed():
	GameController.load_checkpoint()
