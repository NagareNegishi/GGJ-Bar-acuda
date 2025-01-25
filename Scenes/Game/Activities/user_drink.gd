extends Node2D

enum GlassTypes {
	NONE,
	SHORT,
	TALL,
	WINE,
	FLOAT
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
@onready var soda_sprite = $Glass/Soda

enum IceTypes{
	NONE = 0,
	ONE = 1,
	TWO = 2
}
var selected_ice := IceTypes.NONE
@onready var ice_sprite = $Glass/Ice

enum StrawTypes{
	NONE,
	STRAIGHT,
	BENDY,
	CURLY
}
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
