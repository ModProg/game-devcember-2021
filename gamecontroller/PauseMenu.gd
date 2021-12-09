extends Control

func _on_ResumeButton_pressed():
	GameController.resume_paused()


func _on_QuitButton_pressed():
	GameController.quit_game()
