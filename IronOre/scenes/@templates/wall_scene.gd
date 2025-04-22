extends Node2D

var text_speed = 60
@onready var dialogue_box = $WallText/text_ui/PanelContainer/MarginContainer/RichTextLabel
@onready var char_box = $charText/Character
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
"My fingers fly across the keyboard, the blue glow of research papers and code samples lighting up my face. How do languages actually work? The question burns in my skull, urgent and electric. I need to crack this open. I start digging—forums, textbooks, ancient forum threads buried under layers of internet dust. Hours melt away.",
"And then—there it is. Parsers. A cascade of logic that turns words into action. Tokenizers. Chiseling raw text into meaningful blocks, like sculpting syntax from marble. My screen flickers with diagrams of abstract syntax trees, branches spiraling into fractal precision. I lean closer, breath catching. It’s… beautiful. A map of thought, a scaffold for meaning.",
"But then—assembly language. The shadow beneath the glitter. Lines of cryptic commands, raw and unapologetic. My throat tightens. This is where the magic turns real, where abstractions bleed into the machine’s veins. My notebook fills with feverish scribbles: registers, opcodes, memory addresses. The words tremble on the page, alive.",
"I sit back, hands shaking. All these pieces—parsers dissecting intent, tokens like puzzle pieces, trees branching into logic, assembly whispering to silicon—they’re connected. A symphony. And I… I’m conducting it. The realization hits like a spark. This is how you build a universe.",
"The clock blinks 3:47 a.m. I don’t care. My project pulses in my chest now, no longer a dream but a heartbeat. I just need to build."
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
				Global.update_state(69,69,69)
				Global.goto_gameplay()
