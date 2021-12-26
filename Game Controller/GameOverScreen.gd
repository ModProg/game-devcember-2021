extends Control



func _on_RetryButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.load_checkpoint()


func _on_QuitButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.quit_game()
