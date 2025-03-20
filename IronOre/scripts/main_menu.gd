extends Node2D

var dialogue_scene = preload("res://scenes/generic_dialogue.tscn").instantiate()

var curr_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.global_true:
		print("true")
	$ui/new.pressed.connect(_new_game)
	$ui/load.pressed.connect(_load_game)
	$ui/exit.pressed.connect(Global.exit)
	
	curr_scene = Global.load_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	pass


func _load_game():
	print("open previous game")

	curr_scene = Global.load_game()
	get_tree().root.add_child(curr_scene)
	get_tree().root.remove_child($"..")
	pass

func _new_game():
	print("make new game")

	curr_scene = Global.reset_game()
	get_tree().root.add_child(curr_scene)
	get_tree().root.remove_child($"..")
	pass
