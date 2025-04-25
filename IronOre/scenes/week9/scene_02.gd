extends Node2D


@onready var ch1 = $choice/choice_ui/ch1
@onready var ch2 = $choice/choice_ui/ch2
@onready var ch3 = $choice/choice_ui/ch3

var text_length:int = 0
var display_text_len:float = 0

var choice_lines = [
	"Fix the LLVM implementation"
]

func _ready():
	ch1.hide()
	ch2.hide()
	ch3.text = choice_lines[0]
	
	
	ch3.pressed.connect(ch3_f)
	pass

func ch3_f():
	print("Choice 3")
	Global.update_state(3)
	Global.goto_next_scene()
	pass
