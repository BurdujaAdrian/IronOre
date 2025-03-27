extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
@onready var gameplay_ui = $gameplay_ui
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
	"As you "
]

func _ready() -> void:
	gameplay_ui.hide()

	# Correct way to connect the signals using the full path
	$gameplay_ui/work.pressed.connect(_work)
	$gameplay_ui/learn.pressed.connect(_learn)
	$gameplay_ui/relax.pressed.connect(_relax)
	
	if not Global.is_friend:
		$gameplay_ui/work.hide()

	dialogue_box.clear()
	text_length = text_lines[0].length()
	display_text_len = 0

func _hide_choices():
	$gameplay_ui/work.hide()
	$gameplay_ui/learn.hide()
	$gameplay_ui/relax.hide()


func _process(delta):
	if display_text_len < text_length:
		display_text_len += text_speed * delta
		var shown_text = text_lines[0].substr(0, int(display_text_len))
		dialogue_box.text = shown_text
	else:
		if not gameplay_ui.visible:
			if Global.study < 5:
				$gameplay_ui/work.hide()  # hide 'work' if it exists
				$gameplay_ui/relax.text = "Give up on language"
				$gameplay_ui/learn.text = "Use ChatGPT"
			gameplay_ui.show()


func _work():
	_hide_choices()
	Global.llvm_route = false
	Global.lang += 1
	Global.stress += 1
	dialogue_box.text = "You are strugling with llvm's convoluted system, and tells this to the friend. They
	tells that they've heard before about how awful to work with llvm is and that
	they even know a better alternative: qbe. After a bit of research, you decide
	to use qbe instead."

func _relax():
	_hide_choices()
	if Global.study < 5:
		Global.study += Global.lang
		Global.lang = 0
		dialogue_box.text = "You've decided to stop focusing on building the language. All remaining effort shifts into study. Maybe this path wasn't for you after all."
	else:
		Global.llvm_route = true
		Global.stress += 1
		dialogue_box.text = "You are struggling with LLVM's convoluted system, and you still want to push forward."

func _learn():
	_hide_choices()
	if Global.study < 5:
		Global.lang += 2
		Global.stress += 1
		dialogue_box.text = "You decide to use ChatGPT to help you move forward. With its guidance, you're able to make faster progress—though it's still a bit stressful."
	else:
		Global.llvm_route = false
		Global.lang -= 1
		Global.stress += 1
		dialogue_box.text = "You decided to look for alternatives, and stumbled upon discussions about how awful LLVM is. After research, you chose QBE instead."
