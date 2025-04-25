extends Node2D

var text_speed = 60
@onready var dialogue_box = $WallText/text_ui/PanelContainer/MarginContainer/RichTextLabel
@onready var char_box = $charText/Character
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
"The LLVM IR glitches onscreen, a kaleidoscope of %tmp registers and br labels. I’ve rewritten the same basic block six times. Six. The verifier still screams: “PHI node non-deterministic!”
",
"“Why?” I hiss, stabbing the code. The control flow graph looks right. The dominator tree should be valid. But LLVM’s docs are hieroglyphs, and the forum threads all end with “Just use the API.”
",
"I fork another GitHub branch. llvm_last_try. Rewrite the AST-to-IR translation. Hand-roll a pass manager. Link against libLLVM.
",
"New Error: 
```
Segmentation fault (core dumped) at llvm::PassRegistry::getPassRegistry().
```
",
"“What’s a pass registry?!” I scream at the screen. My chair slams into the wall. The neighbor bangs back.
",
"At dawn, I’m still debugging linker flags. The compiler emits a binary. It crashes.
",
"I don’t cry. But my hands smell like burnt coffee and defeat.
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
				Global.update_state(1,9)
				Global.goto_gameplay()
