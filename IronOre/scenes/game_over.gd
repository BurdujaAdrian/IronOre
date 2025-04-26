extends Node2D


@onready var ch1 = $choice/choice_ui/ch1
@onready var ch2 = $choice/choice_ui/ch2
@onready var ch3 = $choice/choice_ui/ch3

var text_length:int = 0
var display_text_len:float = 0

var choice_lines = [
	"Do choice 1",
	"Do choice 2",
	"Do choice 3",
]

func _ready():
	ch1.text = choice_lines[0]
	ch2.text = choice_lines[1]
	ch3.text = choice_lines[2]
	
	ch1.pressed.connect(ch1_f)
	ch2.pressed.connect(ch2_f)
	ch3.pressed.connect(ch3_f)
	pass

func ch1_f():
	print("Choice 1")
	pass
func ch2_f():
	print("Choice 2")
	pass
func ch3_f():
	print("Choice 3")
	pass
