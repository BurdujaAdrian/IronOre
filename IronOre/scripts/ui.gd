extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$generic_ui/save.pressed.connect(Global.save_game)
	$generic_ui/exit.pressed.connect(Global.exit)
	$generic_ui/main.pressed.connect(Global.goto_main)
	pass # Replace with function body.
