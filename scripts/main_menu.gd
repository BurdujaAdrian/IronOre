extends Node2D

var dialogue_scene = preload("res://scenes/generic_dialogue.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.global_true:
		print("true")
	$ui/new.pressed.connect(_new_game)
	$ui/exit.pressed.connect(Global.exit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	pass


func _new_game():
	print("make new game")

	get_tree().root.add_child(dialogue_scene)
	get_tree().root.remove_child($"..")
	pass
