class_name OrderUI
extends Control

@onready var text_field = $TextContainer
@onready var text_label = $TextContainer/TextLabel

# display the order in the UI
func display_text(new_text: String):
	text_label.text = new_text