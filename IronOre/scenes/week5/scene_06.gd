extends Node2D

var text_speed = 60
@onready var dialogue_box = $WallText/text_ui/PanelContainer/MarginContainer/RichTextLabel
@onready var char_box = $charText/Character
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
"The lecture hall vibrates with applause as Vogt steps to the podium. I slouch in my seat, psychology textbook propped open on my knees. Soc Exam 101: Cognitive Dissonance. Tomorrow.
",   

"“Language design,” Vogt begins, “is about bridging the gap between human intent and machine logic.”
",   
"I underline “B.F. Skinner” in my notes, jaw clenched. Why did I skip last week’s psych seminar? The projector flashes a slide about lexical ambiguity. My eyes dart to Vogt’s diagrams—elegant, irrelevant.
",   
"“Consider how a parser negotiates meaning—”
",    
"Negotiates. I scribble: “Festinger’s Theory: Conflict arises when beliefs clash with actions.”
",   
"Vogt’s voice sharpens. “Your compiler isn’t a tool. It’s a translator of human thought.”
",   
"My pen stalls. Human thought. Skinner. Pavlov. Conditioning. The words blur. I glance up—Vogt’s sketching a state machine on the board, arrows looping like synaptic pathways. For a heartbeat, it fits. Psychology and parsers, tangled in some meta-pattern—
",   
"No. I shake myself. Delusion. Sleep deprivation.
",   
"I flip to a crammed chart: Maslow’s Hierarchy vs. Behavioral Conditioning. The student beside me gasps at a code demo. I don’t look.
",  
"By the time Vogt finishes, my margins swarm with hybrid notes:
“Semantic analysis → cognitive bias?
Innate grammar → Chomsky vs. Vogt?
STUDY SCHEDULE BROKEN.”
", 

"The crowd files out, buzzing with quotes. I stay, grinding my molars. Two hours wasted. Two hours not learning Skinner’s rats.
",  
"But as I leave, a phrase lingers, uninvited:
“A language is a mirror. What do you see in it?”",  

"I don’t have an answer. For either subject.
",  
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
