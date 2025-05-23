
extends Node2D

var text_speed = 60
@onready var dialogue_box = $WallText/text_ui/PanelContainer/MarginContainer/RichTextLabel
@onready var char_box = $charText/Character
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [

"The terminal pings—a system update notification. I click “Install” absently, eyes glued to the lexer’s new string interpolation feature.
",
"Next morning:
",
"The compiler crashes on startup.
",
"error: 
```
llvm::Expected<llvm::orc::ThreadSafeModule> llvm::orc::IRCompileLayer::emit: mismatched IR version (expected 14, got 15)
```
",
"I freeze. LLVM 15. Released yesterday.
",
"Error Log Dive:
",
"
```
/include/llvm/IR/PassManager.h:523: virtual void llvm::PassBuilder::parseModulePasses(llvm::PassBuilder::ModulePassManager&): Assertion failed!
```
",
"I scour the release notes. “Removed legacy pass manager support.” My entire optimization pipeline relies on it.
",
"Rewrite the pass manager. Use the new ModulePassManager API.
",
"New error: 
```
undefined reference to llvm::createFunctionInliningPass()
```
",
"Deprecated. Removed.
",
"I fork the LLVM 14 branch. Compile from source.
",

"
```
CMake error: Could NOT find Z3 (missing: Z3_LIBRARIES)
```
",
"The universe laughs.
",
"Friday, 3 a.m.:
",
"The compiler runs. Barely. 2 + 2 returns 4.
",
"The if statement tests crash with:
```
llvm::sys::DynamicLibrary::SearchForAddressOfSymbol(): symbol not found: _ZN4llvm15TargetRegistry14lookupTargetERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERS6_PS6_
```
",
"I don’t scream. I don’t cry.
",
"I book a lecture hall for Monday. To sleep.
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
				Global._stress()
				Global.update_state(1,12)
				Global.goto_gameplay()
