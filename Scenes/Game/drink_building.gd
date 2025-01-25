extends Node2D

enum ActivityStates{
	GLASS = 0,
	SODA = 1,
	ICE = 2,
	STRAW = 3
}

@onready var user_drink = $UserDrink

@onready var glass_selection = $GlassesCupsBottles
@onready var soda_machine = $SodaMachine
@onready var ice_machine = $IceMachine
@onready var straw_selection = $StrawSelection

#var activity = [$GlassesCupsBottles, $SodaMachine, $IceMachine, $StrawSelection]
var curr_act_state =  ActivityStates.GLASS;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	user_drink.hide()
	soda_machine._disable_snapping()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match curr_act_state :
		ActivityStates.GLASS :
			#user_drink.disable_drag()
			$GlassesCupsBottles.show()
			$SodaMachine.hide()
			$IceMachine.hide()
			$StrawSelection.hide()
		ActivityStates.SODA :
			#user_drink.enable_drag()
			soda_machine._enable_snapping()
			$GlassesCupsBottles.hide()
			$SodaMachine.show()
			$IceMachine.hide()
			$StrawSelection.hide()
		ActivityStates.ICE :
			soda_machine._disable_snapping()
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

func _on_wide_glass_btn_pressed() -> void:
	user_drink.selected_glass = user_drink.GlassTypes.WIDE
	user_drink.glass_sprite.texture = user_drink.glass_images[user_drink.GlassTypes.WIDE]
	user_drink.show()
	print("short glass selected")

func _on_tall_glass_btn_pressed() -> void:
	user_drink.selected_glass = user_drink.GlassTypes.TALL
	user_drink.glass_sprite.texture = user_drink.glass_images[user_drink.GlassTypes.TALL]
	user_drink.show()
	print("tall glass selected")

func _on_sundae_glass_btn_pressed() -> void:
	user_drink.selected_glass = user_drink.GlassTypes.SUNDAE
	user_drink.glass_sprite.texture = user_drink.glass_images[user_drink.GlassTypes.SUNDAE]
	user_drink.show()
	print("wine glass selected")

func _on_milkshake_glass_btn_pressed() -> void:
	user_drink.selected_glass = user_drink.GlassTypes.MILK
	user_drink.glass_sprite.texture = user_drink.glass_images[user_drink.GlassTypes.MILK]
	user_drink.show()
	print("float glass selected")
	
###SODA SELECTION###

func _on_kelp_btn_pressed() -> void:
	#check if soda is in the area
	if soda_machine._check_in_area():
		user_drink.selected_soda = user_drink.SodaTypes.KELPACOLA
		print("kelp soda selected")
	else:
		print("no glass in the drink zone!!")

func _on_sarsa_btn_pressed() -> void:
	if soda_machine._check_in_area():
		user_drink.selected_soda = user_drink.SodaTypes.SARSAKRILLA
		print("sarsa soda selected")
	else:
		print("no glass in the drink zone!!")
	
func _on_mollusk_btn_pressed() -> void:
	if soda_machine._check_in_area():
		user_drink.selected_soda = user_drink.SodaTypes.MOLLUSKDEW
		print("moll soda selected")
	else:
		print("no glass in the drink zone!!")
	
func _on_lp_btn_pressed() -> void:
	if soda_machine._check_in_area():
		user_drink.selected_soda = user_drink.SodaTypes.MOLLUSKDEW
		print("not l & p soda selected")
	else:
		print("no glass in the drink zone!!")

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

func _disable_drag() -> void:
	pass
	
func _enable_drag() -> void:
	pass


func _on_serve_drink_btn_pressed() -> void:
	#TO DO: drink comparrison (emit signal and compare enums?)
	#reset user drink
	curr_act_state = 0
	$CanvasLayer/ServeDrinkBtn.hide()
	$CanvasLayer/NextActivityBtn.show()


func _add_ice() -> void:
	if user_drink.no_of_ice >= 2:
		print("you cannot possibly put more ice in this glass!")
	else:
		user_drink.no_of_ice+=1
		user_drink.selected_ice = user_drink.IceTypes.keys()[user_drink.no_of_ice]
	
