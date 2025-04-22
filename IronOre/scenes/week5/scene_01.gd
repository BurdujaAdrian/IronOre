extends Node2D


func _ready():
	if Global.curr_choice == Global.game_choice.learn:
		print("Go the mentor mini route")
		Global.update_state(2,5)
		Global.goto_next_scene()
	else :
		print("Skip mentor mini route")
		Global.update_state(0,5)
		Global.goto_next_scene()
	pass
