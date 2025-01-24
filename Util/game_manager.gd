extends Node

enum GameStates{
	MENU,
	GAME,
	GOODEND,
	BADEND,
	SECRETTHIRDEND
}

var curr_game_state =  GameStates.MENU;

var audio_util_load = preload("res://Util/Audio_Manager.tscn")
var audio_util

#in case we want multiple levels
var levels = []
var level_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_util = audio_util_load.instantiate()
	add_child(audio_util)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match curr_game_state :
		GameStates.MENU : pass
		GameStates.GAME : pass
		GameStates.GOODEND : pass
		GameStates.BADEND : pass
		GameStates.SECRETTHIRDEND : pass

	
