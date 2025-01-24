extends Node

class_name Order

enum Glass {
	NONE,
	GLASS1,
	GLASS2,
	GLASS3,
	GLASS4
}

enum Ice {
	NONE,
	LIGHT,
	NORMAL,
	EXTRA
}

enum Soda {
	NONE,
	COLA,
	LEMON,
	ORANGE,
	ROOTBEER
}

enum Straw {
	NONE,
	PLASTIC,
	PAPER,
}

var glass: Glass
var ice: Ice
var soda: Soda
var straw: Straw



# Called when the node enters the scene tree for the first time.
func _ready():
	generate_random()


func generate_random():
	randomize()
	glass = Glass.values()[randi() % Glass.size()]
	ice = Ice.values()[randi() % Ice.size()]
	soda = Soda.values()[randi() % Soda.size()]
	straw = Straw.values()[randi() % Straw.size()]

func PrintOut() -> String:
	return "Glass: %s, Ice: %s, Soda: %s, Straw: %s" % [
		Glass.keys()[glass],
		Ice.keys()[ice],
		Soda.keys()[soda],
		Straw.keys()[straw]
	]