extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
@onready var gameplay_ui = $gameplay_ui
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
	"You are getting in close to the home stretch. Now you have to choose a backend for 
the languege. The 1st choice is naturally llvm"
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
	Global.llvm_route = true
	Global.stress += 1
	dialogue_box.text = "You are strugling with llvm's convoluted system, and you still want to push forward"

func _learn():
	_hide_choices()
	Global.llvm_route = false
	Global.lang -= 1
	Global.stress += 1
	dialogue_box.text = "You decided to look for alternatives, while doing so you stumbled upon different forums and discussions that tells you how awful llvm is to work with. After some research, you decided to work with QBE"
