extends Node2D

@onready var character_name_label = $Character/Control/CharacterName
@onready var char_sprite = $Character/Control/Sprite2D
var char_res
func load_character(data):
	if data == "" or data == "Cassy":
		char_sprite.hide()
	else:
		char_sprite.visible = true
		var path = "res://Assets/char/%s.png" % data
		print("char data path: ",path)
		char_res = load(path)
		if char_res == null:
			char_sprite.hide()
			print("character res for ", data, " not found")
		char_sprite.set_texture(char_res)
	pass
