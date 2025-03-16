extends Node2D

@onready var dialogue_box = $ui/PanelContainer/RichTextLabel
@onready var text_length:int = 0
@onready var display_text_len:float = 0
var text_speed = 60
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ui/exit.pressed.connect(_exit_game)
	text_length = len(dialogue_box.text)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if dialogue_box.visible_characters < text_length:
		display_text_len += delta*text_speed
		dialogue_box.visible_characters = floor(display_text_len)
		print("Increase text length, text is ",dialogue_box.visible_characters )
	pass

func _exit_game():
	get_tree().quit(0)
	pass
