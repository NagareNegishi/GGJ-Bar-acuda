extends Sprite2D


var mouse_offset
var delay = 5

@onready var straw_tscn = preload("res://Scenes/Game/Activities/straw.tscn")
		
func _add_draggable_straw() -> void:
	var s = straw_tscn.instantiate()
	s.position = get_global_mouse_position()
	s.is_dragging = true
	get_parent().add_child(s)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if( event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				print("pressed")
				_add_draggable_straw()
				
		else:
			print("released")
			
