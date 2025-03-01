extends Node2D

@onready var default_png = preload("res://icon.svg")

@onready var milk_png = preload("res://Assets/Images/Glasses/milkshakeglassNOwhiteline.png")
@onready var sundae_png = preload("res://Assets/Images/Glasses/sundaeglassNOwhiteline.png")
@onready var tall_png = preload("res://Assets/Images/Glasses/tallglassNOwhiteline.png")
@onready var wide_png = preload("res://Assets/Images/Glasses/wideglassNOwhiteline.png")

@onready var glass_images = [default_png, wide_png, tall_png, sundae_png, milk_png]

@onready var m_g = preload("res://Assets/Images/SodaMachine/SodaColours/milkshakegreen.png")
@onready var m_p = preload("res://Assets/Images/SodaMachine/SodaColours/milkshakepurple.png")
@onready var m_r = preload("res://Assets/Images/SodaMachine/SodaColours/milkshakered.png")
@onready var m_y = preload("res://Assets/Images/SodaMachine/SodaColours/milkshakeyellow.png")
@onready var milk_soda = [m_g, m_r, m_p, m_y]

@onready var s_g = preload("res://Assets/Images/SodaMachine/SodaColours/sundaegreen.png")
@onready var s_p = preload("res://Assets/Images/SodaMachine/SodaColours/sundaepurple.png")
@onready var s_r = preload("res://Assets/Images/SodaMachine/SodaColours/sundaered.png")
@onready var s_y = preload("res://Assets/Images/SodaMachine/SodaColours/sundaeyellow.png")
@onready var sun_soda = [s_g, s_r, s_p, s_y]

@onready var t_g = preload("res://Assets/Images/SodaMachine/SodaColours/tallgreen.png")
@onready var t_p = preload("res://Assets/Images/SodaMachine/SodaColours/tallpurple.png")
@onready var t_r = preload("res://Assets/Images/SodaMachine/SodaColours/tallred.png")
@onready var t_y = preload("res://Assets/Images/SodaMachine/SodaColours/tallyellow.png")
@onready var tall_soda = [t_g, t_r, t_p, t_y]

@onready var w_g = preload("res://Assets/Images/SodaMachine/SodaColours/widegreen.png")
@onready var w_p = preload("res://Assets/Images/SodaMachine/SodaColours/widepurple.png")
@onready var w_r = preload("res://Assets/Images/SodaMachine/SodaColours/widered.png")
@onready var w_y = preload("res://Assets/Images/SodaMachine/SodaColours/wideyellow.png")
@onready var wide_soda = [w_g, w_r, w_p, w_y]

@onready var nested_soda_images = [wide_soda, tall_soda, sun_soda, milk_soda]

@onready var straw_holder = $StrawHolder
@onready var ice_holder = $IceHolder

enum GlassTypes {
	NONE,
	WIDE,
	TALL,
	SUNDAE,
	MILK
}
var selected_glass := GlassTypes.NONE
@onready var glass_sprite = $Glass

enum SodaTypes {
	NONE,
	KELPACOLA,
	SARSAKRILLA,
	MOLLUSKDEW,
	LP
}
var selected_soda := SodaTypes.NONE
@onready var soda_sprite = $Soda

enum IceTypes{ #enums incase we get time to do different types
	NONE = 0,
	ONE = 1,
	TWO = 2,
	THREE = 3
}
var no_of_ice = 0;
var selected_ice := IceTypes.NONE
#@onready var ice_sprite = $Glass/Ice

enum StrawTypes{ #enums incase we get time to do different types
	NONE = 0,
	ONE = 1,
	TWO = 2,
	THREE = 3
}
var no_of_straws = 0;
var selected_straw := StrawTypes.NONE
#@onready var straw_sprite = $Glass/Straw
		
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#glass_sprite.hide()
	#$DrinkArea.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _reset_drink() -> void:
	# Reset selections
	selected_glass = GlassTypes.NONE
	selected_soda = SodaTypes.NONE
	selected_ice = IceTypes.NONE
	selected_straw = StrawTypes.NONE

	# Reset counters
	no_of_ice = 0
	no_of_straws = 0

	# Reset sprites
	glass_sprite.texture = glass_images[GlassTypes.NONE]
	soda_sprite.texture = null

	# Remove ice and straw nodes
	#for child in get_children():
		#if child.is_in_group("ice") or child.is_in_group("straw"):
			#child.queue_free()
	for child in ice_holder.get_children():
		child.queue_free()
	for child in straw_holder.get_children():
		child.queue_free()

	hide()
