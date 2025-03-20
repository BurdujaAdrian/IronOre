extends Node

var global_true = true

var study:int

var lang_progress:int

var stress:int

var week:int

var route:routes
enum routes{generic,gpt}

var last_choice:game_choice
var curr_choice:game_choice
var last_line_id:int

enum game_choice{study,work,relax}

func _ready() :
		
	pass

func save_game() :
	print("saving game...")
	pass
	
func load_game():
	print("loading game ...")
	pass
	

func reset_game():
	pass

func exit() :
	get_tree().quit(0)
	pass
