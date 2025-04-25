extends Node2D


func _ready():
	if Global.llvm_route:
		print("Go the llvm route")
		Global.update_state(2)
		Global.goto_next_scene()
	else :
		print("Skip llvm roue")
		Global.update_state(0)
		Global.goto_next_scene()
	pass
