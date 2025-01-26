extends Node
class_name FishPictureBook

# Class for storing fish images

var fish_images = {
	"FISH": [
		preload("res://Scenes/Game/Fish/temp fish images/casualfish00.png"),
		preload("res://Scenes/Game/Fish/temp fish images/casualfish01.png"),
		preload("res://Scenes/Game/Fish/temp fish images/coolfish00.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish00.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish01.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish02.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish03.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish04.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish05.png"),
		preload("res://Scenes/Game/Fish/temp fish images/shellfish00.png"),
		preload("res://Scenes/Game/Fish/temp fish images/shellfish01.png"),
		preload("res://Scenes/Game/Fish/temp fish images/smartfish00.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sponge00.png")
	],
	"TURTLE": [
		preload("res://Scenes/Game/Fish/temp fish images/turtle00.png")

	]
}

# return a random fish sprite
func get_random_fish_sprite(type: String) -> Texture2D:
	var images = fish_images[type]
	return images[randi() % images.size()]
