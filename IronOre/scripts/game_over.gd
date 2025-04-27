extends Node2D


@onready var ch1 = $choice_ui2/ch1

var text_length:int = 0
var display_text_len:float = 0

var choice_lines = [
	"Retry",
]

func _ready():
	ch1.text = choice_lines[0]

	
	ch1.pressed.connect(ch1_f)

	pass

func ch1_f():
	print("Retry")
	Global.stress_overload = false
	match Global.last_choice:
		Global.game_choice.work:
			Global._unsafe_work(-1)
			pass
		Global.game_choice.learn:
			Global._unsafe_learn(-1)
			pass

	Global.goto_gameplay()
	pass
