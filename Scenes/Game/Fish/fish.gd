extends Node2D

class_name Fish


"""var fish_images = {
    Type.FISH: [
		],
		Type.TURTLE: [
    ]
}"""





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
var comment: String
#var state: State = State.ENTERING



# Called when the node enters the scene tree for the first time.
func _ready():
	order = Order.new()
	order.generate_random()
	#set_random_sprite()
	#set_sprite()

	print("order is %s" % order.PrintOut())
	request_order()

"""func set_random_sprite():
	var images = fish_images[type]
	var random_texture = images[randi() % images.size()]
	sprite.texture = random_texture"""

func set_sprite():
	var fish_picture_book = FishPictureBook.new()
	sprite.texture = fish_picture_book.get_random_fish_sprite(Type.keys()[type])


# display the order in UI and place the order to the shop
func request_order():
	display_order.emit(order.PrintOut())
	place_order.emit()

# receive the drink from the shop
func receive_drink(drink: String):
	self.drink = drink
	print("Received drink: %s" % drink)
	calculate_satisfaction()
	generate_comment()
	make_payment()

# calculate the satisfaction based on the drink
func calculate_satisfaction():
	if drink == order.PrintOut():       										#######"need to compare the drink and the order"
		satisfaction = 100
	else:
		satisfaction = 0                                                        ########### too harsh
	print("Satisfaction: %d" % satisfaction)

# make a comment about the drink
func generate_comment():
	if satisfaction == 100:
		comment = "Delicious!"
	else:
		comment = "Yuck!"
	display_order.emit(comment)

# pay the order
"to global? shop?"
func make_payment():
	pay.emit(satisfaction)
	print("Paid %d" % satisfaction)

# leave the shop
func leave_shop():
	left_shop.emit()
	queue_free()








# print out the fish info for debugging
func get_info() -> String:
	return "Type: %s, Adult: %s, Satisfaction: %d, Order: %s" % [
		Type.keys()[type],
		str(is_adult),
		satisfaction,
		order.PrintOut()
	]