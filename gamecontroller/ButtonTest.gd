extends Button

func _on_Button_pressed():
	print("aca")
	GameController.load_level("res://gamecontroller/scene2.tscn")
