extends Node2D


func _ready():
	if Global.learn < Global.MIN_STUDY:
		print("Go the 'problems with uni' route")
		Global.update_state(2)
		Global.goto_next_scene()
	else :
		print("Skip alt route, go directly next")
		Global.update_state(0)
		Global.goto_next_scene()
	pass
