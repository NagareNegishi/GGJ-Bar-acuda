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
	"I hope the Mollusk Dew \ndoesn't attract any sharks.",
	"Not to be salty, \nbut this is taking a while.",
	"I hope \nyou don't mind me piering in.",
	"Do you sell any merch? \nI need a new t-shirt.",
	"You've never done this before, \nhave you?",
	"Rest in peace, \nStephen Hillenburg.",
	"Imagine if physics \napplied to \nanthropomorphic sea life.",
	"Life's a beach, \nand then you die.",
	"I'm a Pisces.",
	"I think Jaws is \none of Spielberg's \nweakest films.",
]


signal display_order(item_name: String, fish_name: String)
signal place_order()
signal pay(amount: int)
signal left_shop()

@onready var sprite = $Sprite2D
@onready var panel = $Panel
@onready var label = $Panel/Label
@onready var satisfaction_timer = $SatisfactionTimer
@onready var satisfaction_bar_bg = $SatisfactionBar/Background
@onready var satisfaction_bar_fill = $SatisfactionBar/Fill


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
var deduction_per_mismatch = 10
var comment: String
var fish_name: String

# animation
var start_position: Vector2
var end_position: Vector2
var tween: Tween



# Called when the node enters the scene tree for the first time.
func _ready():
	order = Order.new()
	order.generate_random()
	set_sprite()

	# Setup positions
	setup_position()
	# set up the timer
	setup_timer()

	request_order()

# Setup position
func setup_position():
	start_position = Vector2(-100, position.y)  # Start off-screen left
	end_position = Vector2(position.x, position.y)  # Current position is end position
	position = start_position
	modulate.a = 0  # Start fully transparent
	enter_animation()

# set the timer
func setup_timer():
	satisfaction_timer = Timer.new()
	satisfaction_timer.wait_time = 1.0
	satisfaction_timer.connect("timeout", _on_satisfaction_timer_timeout)
	add_child(satisfaction_timer)
	satisfaction_timer.start()


# Decrease satisfaction over time
func _on_satisfaction_timer_timeout():
	satisfaction = max(0, satisfaction - 1)  # Prevent going below 0
	#print("Satisfaction: %d" % satisfaction)
	update_satisfaction_bar()

# update the satisfaction bar
func update_satisfaction_bar():
	var filled_height = (satisfaction / 100.0) * 200
	satisfaction_bar_fill.position.y = satisfaction_bar_bg.position.y + (200 - filled_height)
	satisfaction_bar_fill.size.y = filled_height
	var t = satisfaction / 100.0
	satisfaction_bar_fill.color = Color(
		lerp(0.8, 0.2, t),
		lerp(0.2, 0.8, t),
		0.2,
		0.8
	)

# set the sprite based on the type
func set_sprite():
	var fish_picture_book = FishPictureBook.new()
	var texture = fish_picture_book.get_random_fish_sprite(Type.keys()[type])
	sprite.texture = texture
	# Extract name from texture path
	fish_name = texture.resource_path.get_file().trim_suffix(".png").trim_suffix("00").trim_suffix("01").trim_suffix("02").trim_suffix("03").trim_suffix("04").trim_suffix("05")



# display the order in UI and place the order to the shop
func request_order():
	display_order.emit(order.PrintOut(is_adult), fish_name)
	place_order.emit()

# receive the drink from the shop
func receive_drink(product):
	print("Received drink:")
	# Stop the satisfaction timer
	satisfaction_timer.stop()
	self.drink = product
	calculate_satisfaction()
	generate_comment()
	await get_tree().create_timer(3.0).timeout
	make_payment()

# calculate the satisfaction based on the drink
func calculate_satisfaction():
	# Convert Order's enums to Fish's matching enums for comparison
	var ordered_glass = convert_glass(order.glass)
	var ordered_ice = convert_ice(order.ice)
	var ordered_soda = convert_soda(order.soda)
	var ordered_straw = convert_straw(order.straw)

	if drink["glass"] != ordered_glass:
		satisfaction -= deduction_per_mismatch 
	if drink["soda"] != ordered_soda:
		satisfaction -= deduction_per_mismatch
	if drink["ice"] != ordered_ice:
		print(str(drink["ice"]) + "drink ice")
		print(str(ordered_ice) + "ordered ice")
		satisfaction -= deduction_per_mismatch
	if drink["straw"] != ordered_straw:
		print(ordered_straw)
		satisfaction -= deduction_per_mismatch
	update_satisfaction_bar()


# make a comment about the drink
func generate_comment():
	if satisfaction >= threshold:
		comment = GOOD_COMMENTS[randi() % GOOD_COMMENTS.size()]
	else:
		comment = BAD_COMMENTS[randi() % BAD_COMMENTS.size()]
	display_order.emit(comment, fish_name)

# pay the order
"to global? shop?"
func make_payment():
	#pay.emit(satisfaction)
	GameManager.money += satisfaction
	print("Paid %d" % satisfaction)
	leave_shop()

# leave the shop
func leave_shop():
	# Reverse the enter animation
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", start_position, 1.0).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate:a", 0.0, 0.8)
	# Wait for animation to finish before freeing
	await tween.finished
	left_shop.emit()
	queue_free()

# animation enter
func enter_animation():
	tween = create_tween()
	tween.set_parallel(true)  # Allow multiple properties to animate simultaneously
	tween.tween_property(self, "position", end_position, 1.0).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate:a", 1.0, 0.8)

# print out the fish info for debugging
func get_info() -> String:
	return "Type: %s, Adult: %s, Satisfaction: %d, Order: %s" % [
		Type.keys()[type],
		str(is_adult),
		satisfaction,
		order.PrintOut()
	]

func _on_timer_timeout():
	GameManager._play_fish_noise()
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
	NONE,
	ONE,
	TWO,
	THREE
}

enum StrawTypes{
	NONE,
	ONE,
	TWO,
	THREE
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
		Order.Ice.REGULAR: return IceTypes.TWO
		Order.Ice.EXTRA: return IceTypes.THREE
	return IceTypes.NONE

func convert_soda(soda: Order.Soda) -> SodaTypes:
	match soda:
		Order.Soda.KELPA_COLA: return SodaTypes.KELPACOLA
		Order.Soda.SARSAKOLLA: return SodaTypes.SARSAKRILLA
		Order.Soda.MOLLUSK_DEW: return SodaTypes.MOLLUSKDEW
		Order.Soda.LEMON_AND_PROTOZOA: return SodaTypes.LP
	return SodaTypes.NONE

func convert_straw(straw: Order.Straw) -> StrawTypes:
	match straw:
		Order.Straw.NO: return StrawTypes.NONE
		Order.Straw.ONE: return StrawTypes.ONE
		Order.Straw.TWO: return StrawTypes.TWO
		Order.Straw.THREE: return StrawTypes.THREE
	return StrawTypes.NONE
