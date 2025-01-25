extends Node2D

enum GlassTypes {
	NONE,
	WIDE,
	TALL,
	SUNDAE,
	MILK
}
var selected_glass := GlassTypes.NONE
@onready var glass_sprite = $Glass

@onready var default_png = preload("res://icon.svg")
@onready var milk_png = preload("res://Assets/Images/Glasses/milkshakeglassNOwhiteline.png")
@onready var sundae_png = preload("res://Assets/Images/Glasses/sundaeglassNOwhiteline.png")
@onready var tall_png = preload("res://Assets/Images/Glasses/tallglassNOwhiteline.png")
@onready var wide_png = preload("res://Assets/Images/Glasses/wideglassNOwhiteline.png")

@onready var glass_images = [default_png, wide_png, tall_png, sundae_png, milk_png]

enum SodaTypes {
	NONE,
	KELPACOLA,
	SARSAKRILLA,
	MOLLUSKDEW,
	LP
}
var selected_soda := SodaTypes.NONE
@onready var soda_sprite = $Glass/Soda

enum IceTypes{
	NONE = 0,
	ONE = 1,
	TWO = 2,
	THREE = 3
}
var no_of_ice = 0;
var selected_ice := IceTypes.NONE
@onready var ice_sprite = $Glass/Ice

enum StrawTypes{
	NONE = 0,
	ONE = 1,
	TWO = 2,
	THREE = 3
}
var no_of_straws = 0;
var selected_straw := StrawTypes.NONE
@onready var straw_sprite = $Glass/Straw
		
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#glass_sprite.hide()
	#$DrinkArea.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
