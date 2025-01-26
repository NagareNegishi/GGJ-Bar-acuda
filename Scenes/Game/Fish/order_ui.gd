class_name OrderUI
extends Control

@onready var text_field = $TextContainer
@onready var text_label = $TextContainer/TextLabel
@onready var name_label = $TextContainer/Name

# display the order in the UI
func display_text(new_text: String, name_text: String):
	name_label.text = name_text
	text_label.text = new_text
