extends Node
class_name FishPictureBook

var fish_images = {
	"FISH": [
		#preload("res://assets/fish1.png"),

	],
	"TURTLE": [

	]
}

func get_random_fish_sprite(type: String) -> Texture2D:
	var images = fish_images[type]
	return images[randi() % images.size()]
