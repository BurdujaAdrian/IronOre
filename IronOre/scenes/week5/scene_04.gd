extends Node2D

var text_speed = 60
@onready var dialogue_box = $charText/text_ui/PanelContainer/RichTextLabel
@onready var char_box = $charText/Character
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
"His voice cuts through my cynicism. ",
"Vogt: A language isn’t syntax. It’s a conversation. What do you want to say to the machine—and what’s it whispering back?",
"My pen freezes. Whispering back. My project’s assembly layer flickers in my mind—raw, unrefined. Vogt paces the stage, sketching a parse tree on the board.",
"Vogt: Most languages ask how. I build ones that ask why.",
"I snap my laptop shut.",
"Afterward, I hover at the edge of the crowd, my notebook clutched like a shield. His QA ends. Go. Now. I intercept him at the fire exit.",
"Cassy: Mr. Vogt—I’m building a language. It… it uses a bidirectional parser. For implicit error recovery.",
"He raises an eyebrow.",
"Vogt: Show me.",
"I sketch the algorithm on my arm. He laughs—a sharp, delighted sound.",
"Vogt:You’re using the machine’s ambiguities as features?",
"He scribbles an email on my notebook.",
"Mentor: Send me your spec. I’ll break it for you.",
"The lexer remains unfinished. But for once, I don’t care."
]

var line_timeout:float = 0.5
var text_fully_displayed:bool = false  # Track if text has fully appeared

func _ready():
	display_text()


func _process(delta: float):
	# handle text
	text_length = len(dialogue_box.text)
	
	if dialogue_box.visible_characters < text_length:
		display_text_len += delta * text_speed
		dialogue_box.visible_characters = floor(display_text_len)
	else:
		text_fully_displayed = true  # Text is now fully displayed

	if line_timeout > 0:
		line_timeout -= delta

func display_text():
	if char_box == null:
		dialogue_box.text = text_lines[Global.last_line_id]
		dialogue_box.visible_characters = 0
		display_text_len = 0
		text_fully_displayed = false  # Reset text state
	else:
		dialogue_box.text = text_lines[Global.last_line_id]
		var space = dialogue_box.text.find(" ") # check if it's the 1st occurance of : and not randomly somewhere in text.
		var colon = dialogue_box.text.find(":")
		var char_name = ""
		if space == colon +1 and colon != -1:
			char_name = dialogue_box.text.get_slice(":",0)
			dialogue_box.text = dialogue_box.text.get_slice(":",1)
			print("has char name", char_name)

		char_box.character_name_label.text = char_name
		char_box.load_character(char_name)
		

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
				Global.update_state(1,6)
				Global.goto_gameplay()
