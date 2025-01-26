extends Node

enum GameStates{
	MENU,
	GAME,
	END,
	ENDFR
}

var curr_game_state =  GameStates.MENU;

var audio_util_load = preload("res://Util/Audio_Manager.tscn")
var audio_util

#in case we want multiple levels
var levels = []
var level_index = 0

var money = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_util = audio_util_load.instantiate()
	add_child(audio_util)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match curr_game_state :
		GameStates.MENU : pass
		GameStates.GAME : pass
		GameStates.END : check_end()
		GameStates.ENDFR: pass
		
func check_end():
	if(money > 1000):
		get_tree().change_scene_to_file("res://Scenes/GameEndGood.tscn") #good end
		money = 0
		curr_game_state = GameStates.ENDFR
	else:
		get_tree().change_scene_to_file("res://Scenes/GameEndBad.tscn") #bad end
		money = 0
		curr_game_state = GameStates.ENDFR

func _play_fish_noise():
	audio_util._play_fish_noise()

func _play_ice_noise():
	audio_util._play_ice_noise()
	
func _play_soda_noise():
	audio_util._play_soda_noise()
