extends Node2D

class_name Fish

signal display_order(item_name: String)
signal place_order()
signal pay(amount: int)

@onready var sprite = $Sprite2D

enum Type { ## type of fish, turtle??
	FISH,
	TURTLE
}

"enum State { # emotions for reaction??
	ENTERING,
	BROWSING,
	ORDERING,
	WAITING,
	LEAVING
}"

var type: Type
var is_adult: bool
var order: Order
var satisfaction: int = 100  # 0-100
#var state: State = State.ENTERING



# Called when the node enters the scene tree for the first time.
func _ready():
	order = Order.new()
	order.generate_random()
	print(order.PrintOut())



func request_order():
	display_order.emit(order.PrintOut())
	place_order.emit()

func make_payment():
	pay.emit(satisfaction)

func get_info() -> String:
	return "Type: %s, Adult: %s, Satisfaction: %d, Order: %s" % [
		Type.keys()[type],
		str(is_adult),
		satisfaction,
		order.PrintOut()
	]