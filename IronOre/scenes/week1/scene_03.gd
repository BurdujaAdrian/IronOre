extends Node2D

var text_speed = 60
@onready var dialogue_box = $charText/text_ui/PanelContainer/RichTextLabel
@onready var char_box = $charText/Character
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
"Coffee cups pile up like a ceramic monument to my crumbling sanity. I’m hunched over my desk, code blurring on one screen, lecture notes rotting on the other. “Just one more feature,” I mutter, jamming the backspace key. The compiler spits errors. My compiler and my brain.
",
"A notification blinks: “Assignment due in 6 hours.” My stomach knots. I haven’t slept. Haven’t eaten anything that didn’t come in a wrapper. The language’s grammar rules tangle with textbook diagrams in my skull. I slam the laptop shut. “Why can’t I just—be two people?”",
"The lecture hall reeks of stale air and existential dread. Professor Hayes drones about runtime environments, but all I hear is static. Then—",
"Teacher: You are more important than your grades.",
"The words hang there, glowing. My pen slips from my hand. All those sleepless nights, the panic attacks in the library, the way I’d skipped my best friend’s birthday for a coding marathon—suddenly, it’s absurd. A laugh bubbles up, sharp and disbelieving. Is this permission?",
"I glance at my notes. Scribbled in the margin: “LEXER BUG – FIX ASAP.” For the first time, I don’t reach for my laptop. Instead, I text my roommate: “Dinner? My treat.”",
"The relief feels like falling backward into water. Cold. Terrifying. Alive.",
"The plan crystallizes like a brute-force algorithm finally clicking into elegance. I sketch it out on a napkin—coffee-stained equations of minimum effort, maximum yield. Attend just enough lectures to dodge academic probation. Cluster deadlines, automate notes with a script I’ll hack together later. Prioritize exams worth 70% of the grade, let the rest bleed out.",
"“Optimize,” I whisper, circling the number: 3 absences left. Three free passes to steal back time. My hands tremble, not from guilt, but giddiness. This isn’t surrender—it’s strategy.",
"I open my calendar, color-coding like a war map. Red for compiler work. Blue for exams. Black X’s over lectures I’ll ghost. A smirk tugs my lips. Who knew assembly language would teach me resource allocation?",
"My phone buzzes—a group chat blowing up about some mandatory seminar. I type, fingers steady: “Can’t make it. Migraine.” Lie? Maybe. But the code doesn’t care. The language doesn’t care. It’s waiting, half-built and hungry.",
"I lean back, staring at the ceiling. For the first time in months, my breath doesn’t hitch. The numbers add up. The plan holds. And somewhere between the skipped lectures and stolen hours, I’ll carve out a universe—one semicolon at a time.",
"“Watch me,” I say to the empty room."
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
				Global.update_state(1,2)
				Global.goto_gameplay()
