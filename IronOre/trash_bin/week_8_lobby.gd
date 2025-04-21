extends Node2D

func _ready() -> void:
	var gameplay_ui = $gameplay_ui
	var text_ui = $text_ui
	
	if Global.llvm_route:
		gameplay_ui.hide()
		text_ui.show()
		text_ui.get_node("PanelContainer/RichTextLabel").text = "Because of the llvm, you need to work more so that it could work."
	else:
		gameplay_ui.show()
		text_ui.hide()
		gameplay_ui.get_node("work").pressed.connect(_work)
		gameplay_ui.get_node("learn").pressed.connect(_learn)
		gameplay_ui.get_node("relax").pressed.connect(_relax)

func _learn():
	print("time to learn")
	Global.study += 1
	Global.stress += 1
	get_tree().change_scene_to_file("res://scenes/prologue/week8_uni.tscn")  # Change to the correct path


func _work():
	print("time to work")
	Global.lang += 1
	Global.stress += 1

func _on_exit():
	pass

func _relax() -> void:
	print("time to relax")
	if Global.stress > 0:
		Global.stress -= 1
