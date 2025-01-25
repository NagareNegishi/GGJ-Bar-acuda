extends Node2D

@onready var drop_spots = get_tree().get_nodes_in_group("drop_spots")

func _enable_snapping():
	
	$KelpBtn/KelpDropZone.monitorable = true
	$KelpBtn/KelpDropZone.monitoring = true
	
	$SarsaBtn/SarsaDropZone.monitorable = true
	$SarsaBtn/SarsaDropZone.monitoring = true
	
	$MolluskBtn/MollDropZone.monitorable = true
	$MolluskBtn/MollDropZone.monitoring = true
	
	$LPBtn/LPDropZone.monitorable = true
	$LPBtn/LPDropZone.monitoring = true
	
func _disable_snapping():
	
	$KelpBtn/KelpDropZone.monitorable = false
	$KelpBtn/KelpDropZone.monitoring = false
	
	$SarsaBtn/SarsaDropZone.monitorable = false
	$SarsaBtn/SarsaDropZone.monitoring = false
	
	$MolluskBtn/MollDropZone.monitorable = false
	$MolluskBtn/MollDropZone.monitoring = false
	
	$LPBtn/LPDropZone.monitorable = false
	$LPBtn/LPDropZone.monitoring = false
	
func _check_in_area(ds) -> bool:
	#for ds in drop_spots:
	if ds.get_overlapping_areas().has(get_tree().get_nodes_in_group("drink")[0]): #check if the user drink is in a drop spot, this is done bad, however I will not be fixing it
		return true
	return false
	
