extends Node2D

@onready var drink_building = $DrinkBuilding
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_activity_btn_pressed() -> void:
	if drink_building.user_drink.selected_glass != drink_building.user_drink.GlassTypes.NONE : #we can take this extra if out if we want people to be able to order a pile of straws or something
		if drink_building.curr_act_state == 3:
			drink_building.curr_act_state = 0
		else:
			drink_building.curr_act_state+=1
	else:
		print("you cannot proceed without a glass....")
	
