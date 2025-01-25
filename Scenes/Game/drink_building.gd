extends Node2D

enum ActivityStates{
	GLASS = 0,
	SODA = 1,
	ICE = 2,
	STRAW = 3
}

@onready var user_drink = $UserDrink

#var activity = [$GlassesCupsBottles, $SodaMachine, $IceMachine, $StrawSelection]
var curr_act_state =  ActivityStates.GLASS;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	user_drink.hide()


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
			$CanvasLayer/ServeDrinkBtn.show()
			$CanvasLayer/NextActivityBtn.hide()

###GLASS SELECTION###

func _on_short_glass_btn_pressed() -> void:
	user_drink.selected_glass = user_drink.GlassTypes.SHORT
	user_drink.show()
	print("short glass selected")

func _on_tall_glass_btn_pressed() -> void:
	user_drink.selected_glass = user_drink.GlassTypes.TALL
	user_drink.glass_sprite.show()
	print("tall glass selected")

func _on_wine_glass_btn_pressed() -> void:
	user_drink.selected_glass = user_drink.GlassTypes.WINE
	user_drink.show()
	print("wine glass selected")

func _on_float_glass_btn_pressed() -> void:
	user_drink.selected_glass = user_drink.GlassTypes.FLOAT
	user_drink.show()
	print("float glass selected")
	
###SODA SELECTION###

func _on_kelp_btn_pressed() -> void:
	#check if soda is in the area
	user_drink.selected_soda = user_drink.SodaTypes.KELPACOLA
	print("kelp soda selected")

func _on_sarsa_btn_pressed() -> void:
	user_drink.selected_soda = user_drink.SodaTypes.SARSAKRILLA
	print("sarsa soda selected")
	
func _on_mollusk_btn_pressed() -> void:
	user_drink.selected_soda = user_drink.SodaTypes.MOLLUSKDEW
	print("moll soda selected")
	
func _on_lp_btn_pressed() -> void:
	user_drink.selected_soda = user_drink.SodaTypes.MOLLUSKDEW
	print("moll soda selected")

func _on_next_activity_btn_pressed() -> void:
	if _check_valid() && curr_act_state < 3:
		#if curr_act_state == 3:
			#curr_act_state = 0
		#else:
			#curr_act_state+=1
		curr_act_state+=1
		
func _check_valid() -> bool:
	match curr_act_state :
		ActivityStates.GLASS :
			if(user_drink.selected_glass == user_drink.GlassTypes.NONE):
				print("you cannot proceed without a glass....")
				return false
			else: 
				return true
		ActivityStates.SODA :
			return true
		ActivityStates.ICE :
			return true
		ActivityStates.STRAW :
			return true
				
	return false


func _on_serve_drink_btn_pressed() -> void:
	#TO DO: drink comparrison (emit signal and compare enums?)
	#reset user drink
	curr_act_state = 0
	$CanvasLayer/ServeDrinkBtn.hide()
	$CanvasLayer/NextActivityBtn.show()
