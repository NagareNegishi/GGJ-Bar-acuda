extends Node2D

enum ActivityStates{
	GLASS = 0,
	SODA = 1,
	EXTRAS = 2,
}
signal serve_drink(user_drink: Dictionary)

@onready var user_drink = $UserDrink

@onready var glass_selection = $GlassesCupsBottles
@onready var soda_machine = $SodaMachine
@onready var ice_machine = $IceMachine
@onready var straw_selection = $StrawSelection

@onready var ice = preload("res://Scenes/Game/Activities/ice.tscn")
@onready var straw = preload("res://Scenes/Game/Activities/straw.tscn")


#var activity = [$GlassesCupsBottles, $SodaMachine, $IceMachine, $StrawSelection]
var curr_act_state =  ActivityStates.GLASS;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	user_drink.hide()
	soda_machine._disable_snapping()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match curr_act_state:
		ActivityStates.GLASS:
			$GlassesCupsBottles.show()
			$SodaMachine.hide()
			$IceMachine.hide()
			$StrawSelection.hide()
			$CanvasLayer/ServeDrinkBtn.hide()
			$CanvasLayer/NextActivityBtn.show()

		ActivityStates.SODA:
			soda_machine._enable_snapping()
			$GlassesCupsBottles.hide()
			$SodaMachine.show()
			$IceMachine.hide()
			$StrawSelection.hide()
			$CanvasLayer/ServeDrinkBtn.hide()
			$CanvasLayer/NextActivityBtn.show()
		ActivityStates.EXTRAS:
			soda_machine._disable_snapping()
			$GlassesCupsBottles.hide()
			$SodaMachine.hide()
			$IceMachine.show()
			$StrawSelection.hide()
			$CanvasLayer/ServeDrinkBtn.show()
			$CanvasLayer/NextActivityBtn.hide()
			$CanvasLayer/ServeDrinkBtn.disabled = false
			

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
	if soda_machine._check_in_area($SodaMachine/KelpBtn/KelpDropZone):
		user_drink.selected_soda = user_drink.SodaTypes.KELPACOLA
		user_drink.soda_sprite.texture = user_drink.nested_soda_images[user_drink.selected_glass-1][0]
		print("kelp soda selected")
		GameManager._play_soda_noise()
	else:
		print("no glass in the drink zone!!")

func _on_sarsa_btn_pressed() -> void:
	if soda_machine._check_in_area($SodaMachine/SarsaBtn/SarsaDropZone):
		user_drink.selected_soda = user_drink.SodaTypes.SARSAKRILLA
		user_drink.soda_sprite.texture = user_drink.nested_soda_images[user_drink.selected_glass-1][1]
		print("sarsa soda selected")
		GameManager._play_soda_noise()
	else:
		print("no glass in the drink zone!!")
	
func _on_mollusk_btn_pressed() -> void:
	if soda_machine._check_in_area($SodaMachine/MolluskBtn/MollDropZone):
		user_drink.selected_soda = user_drink.SodaTypes.MOLLUSKDEW
		user_drink.soda_sprite.texture = user_drink.nested_soda_images[user_drink.selected_glass-1][2]
		print("moll soda selected")
		GameManager._play_soda_noise()
	else:
		print("no glass in the drink zone!!")
	
func _on_lp_btn_pressed() -> void:
	if soda_machine._check_in_area($SodaMachine/LPBtn/LPDropZone):
		user_drink.selected_soda = user_drink.SodaTypes.MOLLUSKDEW
		user_drink.soda_sprite.texture = user_drink.nested_soda_images[user_drink.selected_glass-1][3]
		print("not l & p soda selected")
		GameManager._play_soda_noise()
	else:
		print("no glass in the drink zone!!")

func _on_next_activity_btn_pressed() -> void:
	if _check_valid() && curr_act_state < 2:
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
		ActivityStates.EXTRAS :
			return true
				
	return false

func _disable_drag() -> void:
	pass
	
func _enable_drag() -> void:
	pass


func _on_serve_drink_btn_pressed() -> void:
	$CanvasLayer/ServeDrinkBtn.disabled = true
	var drink_data = {
		"glass": user_drink.selected_glass,
		"soda": user_drink.selected_soda,
		"ice": user_drink.selected_ice,
		"straw": user_drink.selected_straw
	}
	emit_signal("serve_drink", drink_data)
	user_drink._reset_drink()# reset drink

func _add_ice() -> void: #signal emitting is for people who remember how to do that :sunglasses:
	if user_drink.no_of_ice >= 3:
		GameManager._play_ice_noise()
		var i = ice.instantiate()
		i.is_drag_enabled = false
		i.position.y -= 30*user_drink.no_of_ice
		i.add_to_group("ice")
		user_drink.ice_holder.add_child(i)
		GameManager.money -=5
		user_drink.no_of_ice+=1
		
		#print("you cannot possibly put more ice in this glass!")
	else:
		print("added ice")
		GameManager._play_ice_noise()
		var i = ice.instantiate()
		i.is_drag_enabled = false
		i.position.y -= 30*user_drink.no_of_ice
		i.add_to_group("ice")
		user_drink.ice_holder.add_child(i)
		user_drink.no_of_ice+=1
		user_drink.selected_ice+=1

func _add_straw() -> void:
	if user_drink.no_of_straws >= 3:
		print("you cannot possibly put more straws in this glass!")
	else:
		print("added straw")
		var s = straw.instantiate()
		s.is_drag_enabled = false
		s.position.y -= 100 + 10*user_drink.no_of_straws
		s.position.x += 3*user_drink.no_of_straws
		s.rotation = 0.2*user_drink.no_of_straws
		s.add_to_group("straw")
		user_drink.straw_holder.add_child(s)
		user_drink.no_of_straws+=1
		user_drink.selected_straw+=1
