class_name FishSpawner
extends Node2D

signal fish_left_refresh

@onready var order_ui = $OrderUI
@onready var book = $Fish_PictureBook
@onready var reject_button = $RejectButton

@export var fish_scene: PackedScene
@export var fish_spawn_interval: float = 0.5
var current_fish: Fish = null

# spawn a fish when the game starts
func _ready():
	var drink_building = get_node_or_null("../DrinkBuilding")
	if drink_building:
		drink_building.serve_drink.connect(_on_serve_drink)
	spawn_fish()

# spawn random fish
func spawn_fish():
	if current_fish != null:
		return
	var fish = fish_scene.instantiate()
	fish.left_shop.connect(_on_Fish_left)
	fish.display_order.connect(order_ui.display_text)
	fish.type = Fish.Type.TURTLE if randf() < 0.2 else Fish.Type.FISH
	fish.is_adult = randf() > 0.2
	add_child(fish)
	current_fish = fish
	reject_button.show()

# serve the drink to the fish
func _on_serve_drink(drink):
	if current_fish:
		reject_button.hide()
		current_fish.receive_drink(drink)


# fish leaves the shop and spawn a new fish after a delay
func _on_Fish_left():
	emit_signal("fish_left_refresh")
	current_fish = null
	await get_tree().create_timer(fish_spawn_interval).timeout
	print("Fish left")
	spawn_fish()

# reject to serve the fish
func _on_reject_button_pressed():
	if current_fish == null:
		print("No fish to reject")
		return
	$RejectButton.disabled = true
	current_fish.leave_shop()
	await get_tree().create_timer(fish_spawn_interval).timeout
	print("Fish rejected")
	$RejectButton.disabled = false

