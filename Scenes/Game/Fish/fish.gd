extends Node2D
class_name Fish

const GOOD_COMMENTS = [
	"Thanks, sea you next time!",
	"Ahhhh, this will tide me over.",
	"Now I just need to figure out \nhow to drink this.",
	"This soda is pretty sharp. \nI'm hooked!",
	"Wow, this place is gonna make waves.",
	"Mmmm, that's worth shelling out for.",
	"This is the best drink \nin the shoal world!",
	"This drink is good for the sole.",
	"O, for tuna!",
	"Delicious! \nThat's a real breath of fresh water.",
	"This will go down swimmingly."
]

const BAD_COMMENTS = [
	"I expected batter from you.",
	"What a waste. \nI don't even have taste buds.",
	"Are you sea-rious? \nThis isn't what I ordered.",
	"Are you shore \nthis is what I ordered?",
	"You're really floundering, \naren't you?",
	"My disappointment \nis immeasurable \nand my day is ruined.",
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

var type: Type
var is_adult: bool
var order: Order
var drink
var satisfaction: int = 100  # 0-100
var threshold: int = 70
var deduction_per_mismatch = 15
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
func receive_drink(product):
	self.drink = product
	calculate_satisfaction()
	generate_comment()
	await get_tree().create_timer(5.0).timeout
	make_payment()

# calculate the satisfaction based on the drink
func calculate_satisfaction():

	# Convert Order's enums to Fish's matching enums for comparison
	var ordered_glass = convert_glass(order.glass)
	var ordered_ice = convert_ice(order.ice)
	var ordered_soda = convert_soda(order.soda)
	var ordered_straw = convert_straw(order.straw)

	if drink.selected_glass != ordered_glass:
		satisfaction -= deduction_per_mismatch
	if drink.selected_soda != ordered_soda:
		satisfaction -= deduction_per_mismatch
	if drink.selected_ice != ordered_ice:
		satisfaction -= deduction_per_mismatch
	if drink.selected_straw != ordered_straw:
		satisfaction -= deduction_per_mismatch


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


"very ugly, but we can avoid code crushing each other"
	## helpers to compare order/drink
enum GlassTypes {
	NONE,
	WIDE,
	TALL,
	SUNDAE,
	MILK
}

enum SodaTypes {
	NONE,
	KELPACOLA,
	SARSAKRILLA,
	MOLLUSKDEW,
	LP
}

enum IceTypes{
	NONE = 0,
	ONE = 1,
	TWO = 2
}

enum StrawTypes{
	NONE,
	STRAIGHT,
	BENDY,
	CURLY
}

func convert_glass(glass: Order.Glass) -> GlassTypes:
	match glass:
		Order.Glass.MILKSHAKE: return GlassTypes.MILK
		Order.Glass.TALL: return GlassTypes.TALL
		Order.Glass.SHORT: return GlassTypes.WIDE
		Order.Glass.STEMMED: return GlassTypes.SUNDAE
	return GlassTypes.NONE

func convert_ice(ice: Order.Ice) -> IceTypes:
	match ice:
		Order.Ice.NO: return IceTypes.NONE
		Order.Ice.LIGHT: return IceTypes.ONE
		Order.Ice.REGULAR, Order.Ice.EXTRA: return IceTypes.TWO
	return IceTypes.NONE

func convert_soda(soda: Order.Soda) -> SodaTypes:
	match soda:
		Order.Soda.KELPA_COLA: return SodaTypes.KELPACOLA
		Order.Soda.SQRSAKOLLA: return SodaTypes.SARSAKRILLA
		Order.Soda.MOLLUSK_DEW: return SodaTypes.MOLLUSKDEW
		Order.Soda.LEMDN_AND_PROTOZOA: return SodaTypes.LP
	return SodaTypes.NONE

func convert_straw(straw: Order.Straw) -> StrawTypes:
	match straw:
		Order.Straw.NO: return StrawTypes.NONE
		Order.Straw.STRAIGHT: return StrawTypes.STRAIGHT
		Order.Straw.PAPER: return StrawTypes.STRAIGHT
		Order.Straw.CURLY: return StrawTypes.CURLY
	return StrawTypes.NONE
