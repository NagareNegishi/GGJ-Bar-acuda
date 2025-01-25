extends Node2D


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
	
