extends Node
class_name Order

const COMMENTS = [
	"One drink, please. Pacifically, \na <order>",
	"I'm sea-riously thirsty. \nI'll have \na <order>",
	"I'm sick of always drinking water. \nGive me \na <order>",
	"Shorely you can make me \na <order>?",
	"A <order>, \nplease. Hold the salt.",
	"I wish for some nautical nonsense. \nHow about \na <order>?",
	"I'm looking for \na <order>, \nif that's up for crabs?",
	"I just got out of seabed. \nA <order> \nwould wake me up.",
	"In light of current events, \nI'm desperate for \na <order>.",
	"What does a fish have to do to \nget a <order> \naround here?"
]

const ChildCOMMENTS = [
	"I want a <order> \nso I grow up big and strong!",
	"Mum says I'm allowed to get \na <order>!"
]

enum Glass {
	MILKSHAKE,
	TALL,
	SHORT,
	STEMMED
}

enum Ice {
	NO,
	LIGHT,
	REGULAR,
	EXTRA
}

enum Soda {
	KELPA_COLA,
	SARSAKOLLA,
	MOLLUSK_DEW,
	LEMON_AND_PROTOZOA
}

enum Straw {
	NO,
	ONE,
	TWO,
	THREE
}

var glass: Glass
var ice: Ice
var soda: Soda
var straw: Straw

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_random()

# randomize the order
func generate_random():
	randomize()
	glass = Glass.values()[randi() % Glass.size()]
	ice = Ice.values()[randi() % Ice.size()]
	soda = Soda.values()[randi() % Soda.size()]
	straw = Straw.values()[randi() % Straw.size()]

# convert the order to a string with random comments
func PrintOut(is_adult: bool = true) -> String:
	var details = "%s \nin a %s glass \nwith %s ice \nand %s straw" % [
		Soda.keys()[soda],
		Glass.keys()[glass],
		Ice.keys()[ice],
		Straw.keys()[straw]
	]
	var comment: String
	if is_adult:
		comment = COMMENTS[randi() % COMMENTS.size()]
	else:
		comment = ChildCOMMENTS[randi() % ChildCOMMENTS.size()]
	return comment.replace("<order>", details)
