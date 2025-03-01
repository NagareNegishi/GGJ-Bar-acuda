extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_start_btn_pressed() -> void:
	GameManager.curr_game_state = GameManager.GameStates.GAME
	get_tree().change_scene_to_file("res://Scenes/Game/Main_Game.tscn")

func _on_settings_btn_pressed() -> void:
	#settings is currently a pop up, can easily be changed to a seperate screen
	var sett = load("res://Scenes/Settings.tscn").instantiate();
	get_tree().current_scene.add_child(sett)

func _on_exit_btn_pressed() -> void:
	get_tree().quit()
