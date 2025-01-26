extends CanvasLayer

func _on_return_btn_pressed() -> void:
	GameManager.curr_game_state = GameManager.GameStates.MENU
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_to_text_btn_pressed() -> void:
	print("aaaa")
	$ToTextBtn.hide()
	$Nobubblestextbox.show()
	$Label.show()
	$ReturnBtn.show()
