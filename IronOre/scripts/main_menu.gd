extends Node2D

var curr_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.global_true:
		print("true")
	$ui/new.pressed.connect(_new_game)
	$ui/load.pressed.connect(_load_game)
	$ui/exit.pressed.connect(Global.exit)
	
	curr_scene = Global.load_game()
	Global.main = $".."


func _load_game():
	print("open previous game")

	curr_scene = Global.load_game()
	var active_scene = Global.main.get_child(0)
	Global.main.remove_child(active_scene)
	Global.main.add_child(curr_scene)
	pass

func _new_game():
	print("make new game")

	curr_scene = Global.reset_game()
	
	var active_scene = Global.main.get_child(0)
	Global.main.remove_child(active_scene)
	Global.main.add_child(curr_scene)
	
	pass
	
