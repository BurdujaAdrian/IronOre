extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
@onready var text_length:int = 0
@onready var display_text_len:float = 0
# Called when the node enters the scene tree for the first time.

func _process(delta: float) -> void:
	text_length = len(dialogue_box.text)
	if dialogue_box.visible_characters < text_length:
		display_text_len += delta*text_speed
		dialogue_box.visible_characters = floor(display_text_len)
		print("Increase text length, text is ",dialogue_box.visible_characters )
	pass
