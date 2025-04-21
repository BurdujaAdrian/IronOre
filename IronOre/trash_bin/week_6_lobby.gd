extends Node2D

var text_speed = 60
@onready var dialogue_box = $text_ui/PanelContainer/RichTextLabel
@onready var gameplay_ui = $gameplay_ui
var text_length:int = 0
var display_text_len:float = 0

var text_lines = [
	"You encountered a vicious bug in the languege. The parser uses recursive descent
fir parsing mathematical expresions, however, for some reason certain expressions 
cause an infinite loop."
]

func _ready() -> void:
	gameplay_ui.hide()

	# Correct way to connect the signals using the full path
	$gameplay_ui/work.pressed.connect(_work)
	$gameplay_ui/learn.pressed.connect(_learn)
	$gameplay_ui/relax.pressed.connect(_relax)
	
	if not Global.is_mentor:
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
	Global.corect_bug = true
	Global.lang += 1
	Global.stress += 1
	dialogue_box.text = "You asked your mentor for help and after a while you had come to a conclusion as to why it got broken, in the end you, with some help, got the problem solved"

func _relax():
	_hide_choices()
	Global.corect_bug = true
	Global.lang += 1
	Global.stress += 1
	dialogue_box.text = "You got the problem and succesfully solved the problem alone"

func _learn():
	_hide_choices()
	Global.corect_bug = false
	Global.lang -= 1
	Global.stress += 1
	dialogue_box.text = "That wasn't the most wise choice, now you need to work twice as much in order to solve the problem"
