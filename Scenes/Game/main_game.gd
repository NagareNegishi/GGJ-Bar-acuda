extends Node2D

@onready var drink_building = $DrinkBuilding
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_activity_btn_pressed() -> void:
	if drink_building.curr_act_state == 3:
		drink_building.curr_act_state = 0
	else:
		drink_building.curr_act_state+=1
	
