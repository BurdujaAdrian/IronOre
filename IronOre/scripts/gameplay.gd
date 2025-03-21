extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$gameplay_ui/work.pressed.connect(_work)
	$gameplay_ui/learn.pressed.connect(_learn)
	$gameplay_ui/relax.pressed.connect(_relax)
	pass # Replace with function body.

		
func _learn() :
	print("time to learn")
	Global.study += 1
	Global.stress+=1
	get_tree().change_scene_to_file("res://scenes/prologue/week2_party.tscn")  # Change to the correct path
	pass

func _work() :
	print("time to work")
	Global.lang	 +=1
	Global.stress+=1
	pass

func _on_exit() :
	pass
func _relax() -> void:
	print("time to relax")
	if Global.stress > 0:
		Global.stress -=1
	pass
