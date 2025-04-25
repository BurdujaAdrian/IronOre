extends Node2D


@onready var ch1 = $choice/choice_ui/ch1
@onready var ch2 = $choice/choice_ui/ch2
@onready var ch3 = $choice/choice_ui/ch3

var text_length:int = 0
var display_text_len:float = 0

var choice_lines = [
"Push on with LLVM",
"Give up on LLVM",
"Ask opinion from a friend"
]

func _ready():
	ch1.text = choice_lines[0]
	ch2.text = choice_lines[1]
	if Global.is_friend:
		ch3.text = choice_lines[2]
	else :
		ch3.hide()
	
	ch1.pressed.connect(ch1_f)
	ch2.pressed.connect(ch2_f)
	ch3.pressed.connect(ch3_f)
	pass

func ch1_f():
	Global.llvm_route = true
	Global.update_state(3)
	Global._stress()
	Global.goto_next_scene()
	pass
func ch2_f():
	Global.update_state(4)
	if Global.lang < Global.MAX_WORK:
		Global._unsafe_work()
	else:
		print("Why game bug")

	Global.goto_next_scene()
	pass
func ch3_f():
	print("Choice 3")
	pass
