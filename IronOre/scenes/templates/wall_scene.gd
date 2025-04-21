extends Node2D

var text_speed = 60
@onready var dialogue_box = $WallText/text_ui/PanelContainer/RichTextLabel
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
]

var line_timeout:float = 0.5
var text_fully_displayed:bool = false  # Track if text has fully appeared

func _ready():
	dialogue_box.text = text_lines[Global.last_line_id]  # Load text
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
	dialogue_box.text = text_lines[Global.last_line_id]
	dialogue_box.visible_characters = 0
	display_text_len = 0
	text_fully_displayed = false  # Reset text state

func _next_line():
	if Global.last_line_id < len(text_lines) - 1:
		Global.last_line_id += 1
		display_text()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == 1 :
		var mouse_pos = get_global_mouse_position()
		if $Control/No_mouse.get_global_rect().has_point(mouse_pos):
			return

		if line_timeout < 0 :
			if not text_fully_displayed :
				print("Show full")
				# If text is not finished displaying, instantly show it
				dialogue_box.visible_characters = len(dialogue_box.text)
				text_fully_displayed = true
				line_timeout = 0.5
			elif Global.last_line_id < len(text_lines) - 1 :
				# Move to next line only when current text is fully shown
				_next_line()
				line_timeout = 0.5
			else :
				Global.scene = 1
				Global.last_line_id = 0
				Global.goto_gameplay()
