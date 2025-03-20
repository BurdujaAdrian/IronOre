extends Node2D

var text_speed = 60
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ui/exit.pressed.connect(_exit_game)
	
	$ui/learn.pressed.connect(_learn)
	$ui/relax.pressed.connect(_relax)
	$ui/work.pressed.connect(_relax)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _exit_game():
	get_tree().quit(0)
	pass

func _learn() -> void:
	print("time to learn")
	pass

func _work() -> void:
	print("time to work")
	pass
	
func _relax()->void:
	print("time to chill")
	pass
