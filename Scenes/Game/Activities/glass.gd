extends Sprite2D
#this code and structure is bad
#(should put all the dragging on the area 2d but the tutorial I was using put it on the sprite and now I must live with the consequences of my actions)
#(tried switching to area 2d for this, but the collision shape was returning a weird rect and it didn't work)

var is_dragging = false
var mouse_offset
var delay = 5

var drop_spots

func _physics_process(delta: float) -> void:
	if is_dragging == true:
		var tween = get_tree().create_tween()
		tween.tween_property(get_parent(), "position", get_global_mouse_position()-mouse_offset, delay * delta)
		
func _input(event: InputEvent) -> void:
	if( event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				print("pressed")
				is_dragging = true
				mouse_offset = get_global_mouse_position()-global_position
		else:
			for ds in drop_spots:
				if ds.get_overlapping_areas() and ds.get_overlapping_areas().has(self.get_node("../DrinkArea")): #this is if we want snapping
					var new_pos = ds.global_position
					var tween = get_tree().create_tween()
					tween.tween_property(get_parent(), "position", new_pos, 0.1)
					
			print("released")
			is_dragging  = false
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drop_spots = get_tree().get_nodes_in_group("drop_spots")
	print(drop_spots)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
