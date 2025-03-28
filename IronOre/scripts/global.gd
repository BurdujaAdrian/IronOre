extends Node

var global_true = true

var main:Node

var learn:int = 0
const MAX_STUDY = 15


var lang:int = 0
const MAX_WORK = 15

var stress:int = 0
const MAX_STRESS = 5
var is_mentor:bool = false
var is_friend:bool = false
var corect_bug:bool = false
var llvm_route:bool = false

var week:int     = 0
var route:routes = routes.prologue; enum routes{main,gpt,prologue}
var scene:int    = 1

var last_choice:game_choice = game_choice.none
var curr_choice:game_choice = game_choice.none
var last_line_id:int=0

enum game_choice{learn,work,relax,none,special}

func _ready() :
		
	pass


var save_path =  "user://player_data.ini"

func save_game() :
	print("saving game...")
	
	var config_file = ConfigFile.new()
	
	config_file.set_value("Variables", "lang", lang)
	config_file.set_value("Variables", "stress", stress)
	config_file.set_value("Variables", "learn", learn)
	config_file.set_value("Variables", "Profesor", is_mentor)
	config_file.set_value("Variables", "drujoc", is_friend)
	config_file.set_value("Variables", "bug", corect_bug)
	
	config_file.set_value("Progress", "week",week)
	config_file.set_value("Progress","route",route)
	config_file.set_value("Progress","scene",scene)
	
	config_file.set_value("Progress","line",last_line_id)
	config_file.set_value("Progress", "last_choice",last_choice)
	config_file.set_value("Progress","curr_choice",curr_choice)
	
	var error = config_file.save(save_path)
	if error:
		print("Error saving game progress: ",error)
	pass
	
func load_game() -> Node:
	print("loading game ...")
	
	var config_file = ConfigFile.new()
	var error = config_file.load(save_path)

	if error != ERR_FILE_NOT_FOUND && error:		
		print("Error loading save file: ",error)
		return null
	
	lang = config_file.get_value("Variables", "lang", lang)
	stress = config_file.get_value("Variables", "stress", stress)
	learn = config_file.get_value("Variables", "learn", learn)
	is_mentor = config_file.get_value("Variables", "Profesor", is_mentor)
	is_mentor = config_file.get_value("Variables", "drujoc", is_friend)
	corect_bug = config_file.get_value("Variables", "bug", corect_bug)

	
	week = config_file.get_value("Progress", "week",week)
	route = config_file.get_value("Progress","route",route)
	scene = config_file.get_value("Progress","scene",scene)
	
	last_line_id = config_file.get_value("Progress","line",last_line_id)
	last_choice = config_file.get_value("Progress", "last_choice",last_choice)
	curr_choice =  config_file.get_value("Progress","curr_choice",curr_choice)
	
	var scene_path
	
	if week == 0:
		scene_path ="res://scenes/prologue/scene%s.tscn" % [scene]
	else:
		scene_path = "res://scenes/week%s/scene_%s%s.tscn" % [week,route,scene]
	
	var scene_node = load(scene_path).instantiate()
	
	return scene_node
	

func reset_game():
	week= 0
	route= routes.prologue
	scene= 1
	
	is_friend = false
	is_mentor = false
	corect_bug = false
	
	learn= 0
	lang= 0
	stress= 0
	
	last_choice = game_choice.none
	curr_choice = game_choice.none
	
	save_game()
	return load_game()

func goto_main():
	var curr_scene = load("res://scenes/main_menu.tscn").instantiate()
	
	var active_scene = Global.main.get_child(0)
	print(get_tree_string())

	Global.main.remove_child(active_scene)
	print(get_tree_string())
	Global.main.add_child(curr_scene)

func exit() :
	get_tree().quit(0)
	pass
	
func work():
	if stress > MAX_STRESS:
		lang+=1
		return
	lang +=3
	
	if lang > MAX_WORK:
		lang = MAX_WORK
		
	stress+=1
	

func study():
	if stress > 5:
		learn+=1
		return
	learn+=3
	
	if learn > MAX_STUDY:
		learn = MAX_STUDY
	stress+=1
	

func relax():
	if stress > 0:
		stress-=1
