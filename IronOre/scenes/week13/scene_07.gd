extends Node2D



func _ready():
	# decide next scene based on ending
	if Global.lang >= Global.MAX_WORK:
		Global.update_state(1,14)
	if Global.gpt:
		Global.update_state(3,14)
	else :
		Global.update_state(2,14)
	
	Global.goto_next_scene()

	pass
