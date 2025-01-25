class_name OrderUI
extends Control


var text_display: RichTextLabel

func _ready():
    var panel = Panel.new()
    panel.size = Vector2(300, 100)
    
    text_display = RichTextLabel.new()
    text_display.position = Vector2(10, 10)
    text_display.size = Vector2(280, 80)
    text_display.bbcode_enabled = true
    
    panel.add_child(text_display)
    add_child(panel)

func display_text(message: String):
    print("displaying text")
    text_display.text = "[center]%s[/center]" % message
