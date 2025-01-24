class_name FishSpawner
extends Node2D


@export var fish_scene: PackedScene
var current_fish: Fish = null

func spawn_fish():
	"if current_fish != null:
		return"
		
	var fish = fish_scene.instantiate()
	fish.type = Fish.Type.values()[randi() % Fish.Type.size()]
	fish.is_adult = randf() > 0.2
	add_child(fish)
	current_fish = fish

	# Connect to fish exit signal
	fish.tree_exiting.connect(func(): current_fish = null)
	print("Fish spawned")
	print(fish.get_info())


func _on_button_pressed():
	spawn_fish()
