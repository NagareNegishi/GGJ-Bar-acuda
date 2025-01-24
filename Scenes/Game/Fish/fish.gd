extends Node2D

class_name Fish

signal display_order(item_name: String)
signal place_order()
signal pay(amount: int)
signal left_shop()

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
var drink: String #Drink
var satisfaction: int = 100  # 0-100
#var state: State = State.ENTERING



# Called when the node enters the scene tree for the first time.
func _ready():
	order = Order.new()
	order.generate_random()
	print(order.PrintOut())


# display the order in UI and place the order to the shop
func request_order():
	display_order.emit(order.PrintOut())
	place_order.emit()

# receive the drink from the shop
func receive_drink(drink: String):
	self.drink = drink
	print("Received drink: %s" % drink)
	make_payment()

# calculate the satisfaction based on the drink
func calculate_satisfaction():
	if drink == order.PrintOut():       										#######"need to compare the drink and the order"
		satisfaction = 100
	else:
		satisfaction = 0                                                        ########### too harsh
	print("Satisfaction: %d" % satisfaction)

# leave the shop
func leave_shop():
	left_shop.emit()
	queue_free()

# pay the order
"to global? shop?"
func make_payment():
	pay.emit(satisfaction)






# print out the fish info for debugging
func get_info() -> String:
	return "Type: %s, Adult: %s, Satisfaction: %d, Order: %s" % [
		Type.keys()[type],
		str(is_adult),
		satisfaction,
		order.PrintOut()
	]