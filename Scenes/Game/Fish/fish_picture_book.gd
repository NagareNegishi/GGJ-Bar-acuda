extends Node
class_name FishPictureBook

# Class for storing fish images

var fish_images = {
	"FISH": [
		preload("res://Scenes/Game/Fish/temp fish images/casualfish00.png"),
		preload("res://Scenes/Game/Fish/temp fish images/coolfish00.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish00.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish01.png"),
		preload("res://Scenes/Game/Fish/temp fish images/sharpfish02.png"),
		preload("res://Scenes/Game/Fish/temp fish images/smartfish00.png")
	],
	"TURTLE": [
		preload("res://Scenes/Game/Fish/temp fish images/turtle00.png")

	]
}

# return a random fish sprite
func get_random_fish_sprite(type: String) -> Texture2D:
	var images = fish_images[type]
	return images[randi() % images.size()]
