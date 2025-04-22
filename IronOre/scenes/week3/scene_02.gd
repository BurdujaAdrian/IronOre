extends Node2D


@onready var ch1 = $choice/choice_ui/ch1
@onready var ch2 = $choice/choice_ui/ch2
@onready var ch3 = $choice/choice_ui/ch3

var text_length:int = 0
var display_text_len:float = 0

var choice_lines = [
	"Go to the party",
	"Go home and relax",
	"Work on the language",
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
	Global.relax()
	Global.is_friend = true
	Global.update_state(3)
	Global.goto_next_scene()
	pass
func ch2_f():
	print("Choice 2")
	Global.relax()
	Global.update_state(4)
	Global.goto_next_scene()
	pass
func ch3_f():
	print("Choice 3")
	Global.work()
	Global.update_state(5)
	Global.goto_next_scene()
	pass
