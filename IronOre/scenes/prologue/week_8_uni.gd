extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
	"Alright, everyone, settle down. By now, the rhythm of the course should feel more familiar.",
	"This week, we’re going to focus on the idea of *patterns* — the recurring structures, symbols, and systems that shape the world around us.",
	"Whether you're analyzing literature, solving equations, or navigating social dynamics, recognizing patterns gives you an edge.",
	"Think about it: the best strategists, the best storytellers, even the best liars — all understand how to anticipate what comes next by looking at what’s come before.",
	"Pay close attention, because this week’s material will show up again later — and not just in the final.",
	"Some may even find it... personally relevant.",
	"...",
	"And remember: in this world, nothing happens by accident. Everything connects."
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
