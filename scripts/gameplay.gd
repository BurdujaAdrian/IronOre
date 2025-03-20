extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$gameplay_ui/work.pressed.connect(_work)
	$gameplay_ui/learn.pressed.connect(_work)
	$gameplay_ui/relax.pressed.connect(_relax)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _learn() -> void:
	print("time to learn")
	pass

func _work() -> void:
	print("time to work")
	pass

func _relax()->void:
	print("time to relax")
	pass
