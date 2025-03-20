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

func _ready() -> void:
		
	pass

func save_game() -> void:
	print("saving game...")
	pass
	
func exit() -> void:
	get_tree().quit(0)
	pass
