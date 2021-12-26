extends Control

func _ready() -> void:
	$CenterContainer/VBoxContainer/ResumeButton.grab_focus()

func _on_ResumeButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.load_checkpoint()

func _on_NewGameButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.start_game()

func _on_QuitGameButton_pressed():
	var gamecontroller = get_node("/root/GameController")
	gamecontroller.quit_game()
