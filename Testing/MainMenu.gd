extends Control

func _on_ResumeButton_pressed():
	GameController.load_checkpoint()

func _on_NewGameButton_pressed():
	GameController.start_game()

func _on_QuitGameButton_pressed():
	GameController.quit_game()
