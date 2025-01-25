extends Node2D


func _add_ice():
	get_parent()._add_ice()
	
func _add_straw():
	get_parent()._add_straw()
