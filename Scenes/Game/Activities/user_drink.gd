extends Node2D


enum GlassTypes {
	NONE,
	SHORT,
	TALL,
	WINE,
	FLOAT
}
var selected_glass := GlassTypes.NONE

enum SodaTypes {
	NONE,
	KELPACOLA,
	SARSAKRILLA,
	MOLLUSKDEW,
	LP
}
var selected_soda := SodaTypes.NONE

enum IceTypes{
	NONE = 0,
	ONE = 1,
	TWO = 2
}
var selected_ice := IceTypes.NONE

enum StrawTypes{
	NONE,
	STRAIGHT,
	BENDY,
	CURLY
}
var selected_straw := StrawTypes.NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
