extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
"The first week of university had begun. The lecture hall was filled with nervous whispers and eager anticipation. Reality settled in quickly as expectations clashed with the harsh truth. Many had arrived with confidence, believing they were ready for the challenges ahead. But the weight of the workload, the pressure to excel, and the realization of the competition around them became overwhelming. Some would rise to the occasion, adapting and pushing forward despite the struggle. Others would falter, questioning if they truly belonged in this place.",
"After 3 hours you went back home and got a good sleep"

]

var line_id:int = 0
var line_timeout:float = 0.5
var text_fully_displayed:bool = false  # Track if text has fully appeared

func _ready():
	dialogue_box.text = text_lines[0]  # Load text
	dialogue_box.visible_characters = 0  # Reset text effect
	display_text_len = 0  # Ensure smooth typing effect starts


func _process(delta: float):
	text_length = len(dialogue_box.text)
	if dialogue_box.visible_characters < text_length:
		display_text_len += delta * text_speed
		dialogue_box.visible_characters = floor(display_text_len)
	else:
		text_fully_displayed = true  # Text is now fully displayed

	if line_timeout > 0:
		line_timeout -= delta

func display_text():
	dialogue_box.text = text_lines[line_id]
	dialogue_box.visible_characters = 0
	display_text_len = 0
	text_fully_displayed = false  # Reset text state

func _next_line():
	if line_id < len(text_lines) - 1:
		line_id += 1
		display_text()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if not text_fully_displayed:
			# If text is not finished displaying, instantly show it
			dialogue_box.visible_characters = len(dialogue_box.text)
			text_fully_displayed = true
		elif line_id < len(text_lines) - 1:
			# Move to next line only when current text is fully shown
			_next_line()
