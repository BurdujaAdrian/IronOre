extends Node2D

var text_speed = 60
@onready var dialogue_box = $WallText/text_ui/PanelContainer/MarginContainer/RichTextLabel
@onready var char_box = $charText/Character
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
	
"The LLVM IR sprawls across my screen, a jagged tapestry of %1 = add i32 %0, 2 and br label %exit. Coffee crusts the mug beside me. The third—or fourth—rewrite of the codegen pass glares back, littered with segmentation fault corpses.
",
"“Lower the AST,” I mutter, fingers cramping. The structs misalign again. i64 masquerades as i32*. The optimizer chokes on opt -O2, spewing hex dumps.
",
"I scrap the generated IR. Hand-code a function:
",
"
```
define i32 @main() {  
  %result = call i32 @evaluate(i32 2, i32 3)  
  ret i32 %result  
}  
```
llc compiles. clang links. The executable runs. Returns 5. A flicker.
",
"Then the real test: the parser’s AST for (2 + 3) * 4. Nodes map to IR—%add = add i32 2, 3, %mul = mul i32 %add, 4.
",
"Error: Instruction does not dominate all uses!
",
"Whiteboard diagrams metastasize—arrows, labels, dominance frontiers. The verifier demands PHI nodes. I carve them into the IR:
",
"
```
%0 = phi i32 [ 2, %entry ], [ %add, %loop ]  
```
The silence is brittle. The optimizer runs. No crashes.
",
"The test passes. 20.
",
"I slump, eyelids sandpaper. The next test—if statements—looms. LLVM’s shadow stretches, unblinking.
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
				Global.work()
				Global.update_state(1,10)
				Global.goto_next_scene()
