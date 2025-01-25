extends Sprite2D


var is_dragging = false
var is_drag_enabled = true
var mouse_offset
var delay = 5

@onready var d = get_tree().get_nodes_in_group("drink")[0]

func _physics_process(delta: float) -> void:
	if is_dragging && is_drag_enabled:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position(), delay * delta)

func _input(event: InputEvent) -> void:
	if(is_drag_enabled):
		if( event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
			if event.pressed:
				if get_rect().has_point(to_local(event.position)):
					print("pressed")
					mouse_offset = get_global_mouse_position()-global_position
					is_dragging = true
					
			else:
				if d.monitoring and d.get_overlapping_areas() and d.get_overlapping_areas().has(self.get_node("IceArea")):
					get_parent()._add_ice()
					#bool check if ice can/has actually been added otherwise ice is still there
					self.queue_free()
					#var new_pos = d.global_position
					#var tween = get_tree().create_tween()
					#tween.tween_property(get_parent(), "position", new_pos, 0.1)
						
				print("released")
				is_dragging  = false
					
