extends Node2D

# 	var curr_scene = load("res://scenes/main_menu.tscn").instantiate()
#	
#	var active_scene = Global.main.get_child(0)
#	print(get_tree_string())
#
#	Global.main.remove_child(active_scene)
#	print(get_tree_string())
# 	Global.main.add_child(curr_scene)


func _ready():
	var acrive_scene = Global.main.get_child(0)
	var scene
	
	match Global.route:
		Global.routes.gpt:
			scene = load("res://scenes/endings/gptending.tscn").insantiate()
		Global.routes.main:
			if Global.lang < Global.MAX_WORK:
				scene = load("res://scenes/endings/okending.tscn").instantiate()
			else :
				scene = load("res://scenes/endings/goodending.tscn").instatiate()
		Global.routes.prologue:
			assert(false,"how did you get here?")

	Global.main.remove_child(acrive_scene)
	Global.main.add_child(scene)
		
	pass
