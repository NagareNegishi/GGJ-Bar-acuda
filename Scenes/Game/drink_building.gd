extends Node2D

enum ActivityStates{
	GLASS = 0,
	SODA = 1,
	ICE = 2,
	STRAW = 3
}



#var activity = [$GlassesCupsBottles, $SodaMachine, $IceMachine, $StrawSelection]
var curr_act_state =  ActivityStates.GLASS;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match curr_act_state :
		ActivityStates.GLASS : 
			$GlassesCupsBottles.show()
			$SodaMachine.hide()
			$IceMachine.hide()
			$StrawSelection.hide()
		ActivityStates.SODA :
			$GlassesCupsBottles.hide()
			$SodaMachine.show()
			$IceMachine.hide()
			$StrawSelection.hide()
		ActivityStates.ICE :
			$GlassesCupsBottles.hide()
			$SodaMachine.hide()
			$IceMachine.show()
			$StrawSelection.hide()
		ActivityStates.STRAW :
			$GlassesCupsBottles.hide()
			$SodaMachine.hide()
			$IceMachine.hide()
			$StrawSelection.show()
