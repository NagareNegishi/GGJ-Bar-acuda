class_name FishSpawner
extends Node2D

@onready var order_ui = $OrderUI
@onready var book = $Fish_PictureBook

@export var fish_scene: PackedScene
@export var fish_spawn_interval: float = 0.5
var current_fish: Fish = null



func spawn_fish():
	if current_fish != null:
		return
		
	var fish = fish_scene.instantiate()
	fish.left_shop.connect(_on_Fish_left)
	fish.display_order.connect(order_ui.display_text)
	fish.type = Fish.Type.values()[randi() % Fish.Type.size()]
	fish.is_adult = randf() > 0.2
	add_child(fish)
	current_fish = fish


	# Connect to fish exit signal
	fish.tree_exiting.connect(func(): current_fish = null)


# fish left
func _on_Fish_left():
	current_fish = null
	await get_tree().create_timer(fish_spawn_interval).timeout
	print("Fish left")
	spawn_fish()





func _on_button_pressed():
	spawn_fish()


	if current_fish != null:
		current_fish.receive_drink(current_fish.order.PrintOut(current_fish.is_adult))
		await get_tree().create_timer(1.0).timeout
		current_fish.leave_shop()




