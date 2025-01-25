extends Node

class_name Order

enum Glass {
	MILKSHAKE,
	TALL,
	SHORT,
	STEMMED
}

enum Ice {
	NONE,
	LIGHT,
	REGULAR,
	EXTRA
}

enum Soda {
	KELPA_COLA,
	SQRSAKOLLA,
	MOLLUSK_DEW,
	LEMDN_AND_PROTOZOA
}

enum Straw {
	NO,
	STRAIGHT,
	PAPER,
	CURLY
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
	return "%s in a %s glass with %s ice and %s straw" % [
		Soda.keys()[soda],
		Glass.keys()[glass],
		Ice.keys()[ice],
		Straw.keys()[straw]	
	]
