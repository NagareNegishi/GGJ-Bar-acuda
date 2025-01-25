extends Node2D
class_name Fish

const GOOD_COMMENTS = [
	"Thanks, sea you next time!",
	"Ahhhh, this will tide me over.",
	"Now I just need to figure out how to drink this.",
	"This soda is pretty sharp. I'm hooked!",
	"Wow, this place is gonna make waves.",
	"Mmmm, that's worth shelling out for.", 
	"This is the best drink in the shoal world!",
	"This drink is good for the sole.",
	"O, for tuna!",
	"Delicious! That's a real breath of fresh water.",
	"This will go down swimmingly."
]

const BAD_COMMENTS = [
	"I expected batter from you.",
	"What a waste. I don't even have taste buds.",
	"Are you sea-rious? This isn't what I ordered.",
	"Are you shore this is what I ordered?",
	"You're really floundering, aren't you?",
	"My disappointment is immeasurable and my day is ruined.",
]

const WAITING_COMMENTS = [
	"Water you doing \nback there??",
	"I'm waiting \nwith baited breath.",
	"Is there anything \nI can do to kelp?",
	"I hope \nthe Mollusk Dew \ndoesn't attract \nany sharks.",
	"Not to be salty, \nbut this is \ntaking a while.",
	"I hope \nyou don't mind me \npiering in.",
	"Do you sell any merch? \nI need a new t-shirt.",
	"You've never \ndone this before, \nhave you?",
	"Rest in peace, \nStephen Hillenburg.",
	"Imagine if physics \napplied to \nanthropomorphic \nsea life.",
	"Life's a beach, \nand then you die.",
	"I'm a Pisces.",
	"I think Jaws is \none of Spielberg's \nweakest films.",
]


signal display_order(item_name: String)
signal place_order()
signal pay(amount: int)
signal left_shop()

@onready var sprite = $Sprite2D
@onready var panel = $Panel
@onready var label = $Panel/Label



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
var threshold: int = 70
var comment: String
#var state: State = State.ENTERING



# Called when the node enters the scene tree for the first time.
func _ready():
	order = Order.new()
	order.generate_random()
	set_sprite()
	request_order()


func set_sprite():
	var fish_picture_book = FishPictureBook.new()
	sprite.texture = fish_picture_book.get_random_fish_sprite(Type.keys()[type])


# display the order in UI and place the order to the shop
func request_order():
	display_order.emit(order.PrintOut(is_adult))
	place_order.emit()

# receive the drink from the shop
func receive_drink(drink: String):
	self.drink = drink
	print("Received drink: %s" % drink)
	calculate_satisfaction()
	generate_comment()
	await get_tree().create_timer(5.0).timeout
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
	if satisfaction >= threshold:
		comment = GOOD_COMMENTS[randi() % GOOD_COMMENTS.size()]
	else:
		comment = BAD_COMMENTS[randi() % BAD_COMMENTS.size()]
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

func _on_timer_timeout():
	panel.visible = true
	label.text = WAITING_COMMENTS[randi() % WAITING_COMMENTS.size()]
	await get_tree().create_timer(5.0).timeout
	panel.visible = false
