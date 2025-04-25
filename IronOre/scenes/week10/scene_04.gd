extends Node2D


@onready var ch1 = $choice/choice_ui/ch1
@onready var ch2 = $choice/choice_ui/ch2
@onready var ch3 = $choice/choice_ui/ch3

var text_length:int = 0
var display_text_len:float = 0

var choice_lines = [
	"Give up on the language to study",
	"Give up and try to use ChatGPT",
]

func _ready():
	ch1.text = choice_lines[0]
	ch2.text = choice_lines[1]
	ch3.hide()
	
	ch1.pressed.connect(ch1_f)
	ch2.pressed.connect(ch2_f)
	pass

func ch1_f():
	print("Choice 1")
	# go to week 14 (endings week) scene 2 (scene for ending 2)
	Global.update_state(2,14)
	Global.goto_next_scene()
	pass
func ch2_f():
	print("Choice 2")

	if Global.lang < Global.MAX_WORK:
		Global.gpt = true
		Global._unsafe_work()
		Global.update_state(5) # go scene describing the decision to use gpt to finish the project
		Global.goto_next_scene()
	else:
		Global.update_state(1,11)
		Global.goto_gameplay()
	pass
