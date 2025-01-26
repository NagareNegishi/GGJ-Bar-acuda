extends Node2D


@onready var f1 = $Fish1
@onready var f2 = $Fish2
@onready var f3 = $Fish3
@onready var f4 = $Fish4

@onready var fishnoises = [f1, f2, f3, f4]

func _play_fish_noise():
	var i = randi_range(0, 3)
	fishnoises[i].play()
	
func _play_ice_noise():
	$IceNoise.play()
	
func _play_soda_noise():
	$SodaNoise.play()
