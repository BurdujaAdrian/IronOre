extends Node2D


func _ready():
	if Global.llvm_route == true:
		print("Another week wasted by using llvm")
		Global.update_state(2)
		Global.goto_next_scene()
	else :
		print("Skip the llvm bullshit")
		Global.update_state(1,12)
		Global.goto_gameplay()
	pass
