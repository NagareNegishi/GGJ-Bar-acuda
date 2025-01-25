extends Sprite2D


var mouse_offset
var delay = 5

#@onready var d = get_tree().get_nodes_in_group("drink")[0]
@onready var ice_tscn = preload("res://Scenes/Game/Activities/ice.tscn")
		
func _add_draggable_ice() -> void:
	var i = ice_tscn.instantiate()
	i.position = get_global_mouse_position()
	i.is_dragging = true
	get_parent().add_child(i)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if( event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				print("pressed")
				_add_draggable_ice()
				
		else:				
			print("released")
			
