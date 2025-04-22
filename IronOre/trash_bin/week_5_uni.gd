extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
	"Welcome back. By now, the rhythm of the course should feel more familiar. This week focuses on applying foundational concepts to practical, real-world scenarios. It's no longer just about definitions and formulas\u2014it's about connecting ideas and thinking critically. Progress may look different for everyone, and that\u2019s perfectly fine. The key is steady effort. Stay engaged with the material, ask questions when needed, and support one another as peers. Let\u2019s begin today\u2019s session with an open mind and a willingness to explore beyond the surface."

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
